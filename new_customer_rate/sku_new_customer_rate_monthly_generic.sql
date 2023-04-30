WITH 
orders AS (
	SELECT
		date_trunc('day', created_at, 'America/Los_Angeles')::date AS date_pst,
		name,
		tags,
		total_price AS total
	FROM
				
		shopify_pkit4_sku_orders
-- 		shopify_pkit6_sku_orders
-- 		shopify_pkit7_sku_orders
-- 		shopify_bkit4_sku_orders
-- 		shopify_bkit6_sku_orders
-- 		shopify_collagen14_sku_orders

	WHERE
		DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2021, 03, 01)
		AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 04, 11)
),
new_orders AS (
	SELECT 
		date_pst,
		ROUND(SUM(total)::NUMERIC, 2) AS new_revenue,
		COUNT(total) AS new_order_count
	FROM 
		orders
	WHERE 
		tags ~* 'new customer'
	GROUP BY 
		date_pst 
),
returning_orders AS (
	SELECT 
		date_pst,
		ROUND(SUM(total)::NUMERIC, 2) AS returning_revenue,
		COUNT(total) AS returning_order_count
	FROM 
		orders
	WHERE 
		tags ~* 'returning customer'
	GROUP BY 
		date_pst 
),
all_orders AS (
	SELECT 
		date_pst,
		ROUND(SUM(total)::NUMERIC, 2) AS total,
		COUNT(total) AS order_count
	FROM 
		orders
	GROUP BY 
		date_pst 
)

SELECT
	DATE_TRUNC('month', all_orders.date_pst)::DATE AS date_month,
	ROUND(SUM(all_orders.total)::NUMERIC, 2) AS total_revenue,
	ROUND(SUM(new.new_revenue)::NUMERIC, 2) AS new_revenue,
	ROUND(SUM(returning_.returning_revenue)::NUMERIC, 2) AS returning_revenue,
	SUM(all_orders.order_count) AS total_orders,
	SUM(new.new_order_count) AS new_order_count,
	SUM(returning_.returning_order_count) AS returning_order_count,
	ROUND((SUM(new.new_order_count) / (SUM(new.new_order_count) + SUM(returning_.returning_order_count))::float)::NUMERIC, 2) AS new_customer_rate
FROM 
	all_orders
FULL JOIN 
	new_orders AS new
	USING (date_pst)
FULL JOIN 
	returning_orders AS returning_
	USING (date_pst)
GROUP BY 
	date_month
ORDER BY 
	date_month ASC