SELECT
	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date AS date_pst,
	ROUND(SUM(total_price)::numeric, 2) AS total,
	COUNT(*) AS order_count
FROM

	/* ATTN */
	shopify_protein50_orders
-- 	shopify_shaker_orders
--	shopify_challenge_orders
-- 	shopify_seven_reasons_orders
-- 	shopify_vanilla_chai_orders
-- 	shopify_collagen50_orders
-- 	shopify_twenty_five_off_orders
-- 	shopify_protein_bundle_orders

	/* TIKTOK */
-- 	shopify_tiktok_protein50_orders

	/* OMG */
-- 	shopify_omg_bing_shopping_orders
-- 	shopify_omg_discovery_orders
-- 	shopify_omg_other_youtube_orders
-- 	shopify_omg_shopping_pmax_orders

	/* INFLUENCERS */
-- 	shopify_influencer_code_orders

-- WHERE
-- 	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 01, 01) 
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 04, 10)
GROUP BY
	date_pst 
ORDER BY
	date_pst DESC