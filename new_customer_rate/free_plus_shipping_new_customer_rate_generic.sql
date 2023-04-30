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
			SELECT
				unique_order,
				DATE(created_at_pst) AS date_pst,
				email,
				total
			FROM
				
				/* ATTN */
				clickfunnels_pkit4_orders
-- 				clickfunnels_pkit6_orders
-- 				clickfunnels_pkit7_orders
-- 				clickfunnels_bkit4_orders
-- 				clickfunnels_bkit6_orders
-- 				clickfunnels_collagen_sms_orders
				
				/* OMG */
-- 				clickfunnels_omg_pkit4_youtube_orders
				
		) AS clickfunnels
	
	LEFT JOIN (
			SELECT
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
				
				/* ATTN */
				shopify_pkit4_sku_orders
-- 				shopify_pkit6_sku_orders
-- 				shopify_pkit7_sku_orders
-- 				shopify_bkit4_sku_orders
-- 				shopify_bkit6_sku_orders
-- 				shopify_collagen14_sku_orders
				
				/* OMG */
-- 				shopify_pkit4_sku_orders
				  
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
WHERE
	date_pst >= MAKE_DATE(2023, 04, 05)
	AND date_pst <= MAKE_DATE(2023, 04, 11)