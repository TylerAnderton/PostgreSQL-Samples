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
		shopify_orders
	WHERE
		DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 02, 24) 
		AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 03, 02)
		AND 
		tags ~* 'promo:fb-protein-promo(,|$)|utm:campaign:attn_cp_protein50_cbo|utm:campaign:attn_protein50(,|$)|utm:campaign:attn-protein50-influencers|utm:campaign:attn_protein50_(fb39|fb23|remarketing|fb39_ig_stor|fb28|fb83|fb32|fb24|fb87|aug|fb_d|rmkt_harmon|cbo|main|cbo_lto_test|bfcm_asc|main_1daycli|cbo4|fb39_reel_cb|cbo3|bfcm|bfcm_cbo|cbo_lto|cbo_lto_nye|gut|gut_1dayclic|main_costcap|main_influen|nye_asc|old_june|cbo_lto_vday|cbo_testing-|sweetsvid|cbo_vchai)'
		AND tags !~* 'subscription recurring'
		
		AND name !~* '[A-Z]' -- exclude cancelled/edited orders
		AND total_price != 0
		
	ORDER BY
		created_at DESC
)

SELECT
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
WHERE total > 0