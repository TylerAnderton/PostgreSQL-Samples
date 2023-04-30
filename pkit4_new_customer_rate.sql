WITH 
orders AS (
	SELECT 
		clickfunnels.date_pst AS date_pst,
		clickfunnels.unique_order AS unique_order,
		clickfunnels.unique_order * shopify.new_order AS new_orders,
		clickfunnels.unique_order * shopify.returning_order AS returning_orders,
		clickfunnels.total AS total,
		clickfunnels.total * shopify.new_order AS new_revenue,
		clickfunnels.total * shopify.returning_order AS returning_revenue
	FROM (
			SELECT DISTINCT
				CASE WHEN (subtotal = 8.95 OR subtotal = 20.91) THEN 1 ELSE 0 END AS unique_order,
				DATE(created_at_pst) AS date_pst,
				email,
				total
			FROM
				clickfunnel_orders_all_time_view
			WHERE
				
				(
			      LOWER(utm_term) IN (
			        'pkit-4-free-shipping', 'pkit-4-bridge'
			      )
			      OR utm_term ~* 'pkit-4-free-shipping-(followup-fb-|var)'
			    )
			    
				AND DATE(created_at_pst) >= MAKE_DATE(2023, 02, 21)
				AND DATE(created_at_pst) <= MAKE_DATE(2023, 02, 28) 
				
		) AS clickfunnels
	
	LEFT JOIN (
			SELECT DISTINCT -- DISTINCT needed to prevent time out
				date_trunc('day'::text, created_at, 'America/Los_Angeles'::text)::date AS date_pst,
				name,
				email,
				CASE WHEN tags ~* 'new customer' THEN
					1							
				ELSE
					0
				END AS new_order,
				CASE WHEN tags ~* 'returning customer' THEN
					1
				ELSE
					0
				END AS returning_order,
				total_price AS total
			FROM 
				"public".shopify_orders,
		jsonb_array_elements(line_items) with ordinality arr(item_object, position)
			WHERE 
				DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 02, 21)
				AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 02, 28)
				
				AND (arr.item_object ->> 'sku')::text IN ('PKIT-4','PKIT-4-R','PKIT-4-STRAW','PKIT-4-CHALLENGE','PKIT-4-CHALLENGE-R') -- exclude multiple orders per day
				
				AND name !~* '[A-Z]' -- exclude cancelled/edited orders
				  
	) AS shopify 
	
	ON LOWER(clickfunnels.email) = LOWER(shopify.email)
	AND clickfunnels.date_pst = shopify.date_pst
)

SELECT
	ROUND(SUM(total)::NUMERIC, 2) AS total_revenue,
	ROUND(SUM(new_revenue)::NUMERIC, 2) AS new_revenue,
	ROUND(SUM(returning_revenue)::NUMERIC, 2) AS returning_revenue,
	SUM(unique_order) AS total_orders,
	SUM(new_orders) AS new_order_count,
	SUM(returning_orders) AS returning_order_count,
	ROUND((SUM(new_orders) / (SUM(new_orders) + SUM(returning_orders))::float)::NUMERIC, 2) AS new_customer_rate
FROM 
	orders