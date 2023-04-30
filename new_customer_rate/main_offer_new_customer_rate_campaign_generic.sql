WITH orders AS (
	SELECT
		date_trunc('day', created_at, 'America/Los_Angeles')::date AS date_pst,
		(regexp_match(tags, 'utm:campaign:([^,]*)')) [1] AS utm_campaign,
		LOWER(tags),
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
		shopify_protein50_orders
	-- 	shopify_shaker_orders
	--	shopify_challenge_orders
	-- 	shopify_collagen50_orders
	--	shopify_twenty_five_off_orders
	
		/* TIKTOK */
	-- 	shopify_tiktok_protein50_orders
	
		/* OMG */
	-- 	shopify_omg_bing_shopping_orders
	-- 	shopify_omg_discovery_orders
	-- 	shopify_omg_shopping_pmax_orders
	
	WHERE
		DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 03, 03) 
		AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 03, 09)
		
		AND name !~* '[A-Z]' -- exclude cancelled/edited orders
		
	ORDER BY
		created_at DESC
)

SELECT
	utm_campaign,
	ROUND(SUM(total)::NUMERIC, 2) AS total_revenue,
	ROUND(SUM(total * new_order)::NUMERIC, 2) AS new_revenue,
	ROUND(SUM(total * returning_order)::NUMERIC, 2) AS returning_revenue,
	COUNT(*) AS total_orders,
	SUM(new_order) AS new_order_count,
	SUM(returning_order) AS returning_order_count,
	CASE 
		WHEN (SUM(new_order) + SUM(returning_order)) = 0 THEN 0
		ELSE ROUND((SUM(new_order) / (SUM(new_order) + SUM(returning_order))::float)::NUMERIC, 2) 
		END AS new_customer_rate
FROM orders 
WHERE 
	total != 0
	AND utm_campaign IS NOT NULL

GROUP BY utm_campaign
ORDER BY utm_campaign ASC