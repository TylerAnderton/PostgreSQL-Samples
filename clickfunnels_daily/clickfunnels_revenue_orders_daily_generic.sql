SELECT
	DATE(created_at_pst) AS date_pst,
	SUM(total) AS revenue,
	COUNT (unique_order) AS order_count
FROM

	/* ATTN */
	clickfunnels_protein50_popup_orders
-- 	clickfunnels_shaker_popup_orders
-- 	clickfunnels_challenge_popup_orders
-- 	clickfunnels_seven_reasons_popup_orders
-- 	clickfunnels_collagen50_popup_orders
-- 	clickfunnels_collagen_sms_orders
-- 	clickfunnels_pkit4_orders
-- 	clickfunnels_pkit6_orders
-- 	clickfunnels_pkit7_orders
-- 	clickfunnels_bkit4_orders
-- 	clickfunnels_bkit6_orders
-- 	clickfunnels_pkit_bkit_orders
-- 	clickfunnels_pkit_bkit_shaker_orders
-- 	clickfunnels_protein_bundle_orders

	/* TIKTOK */
-- 	clickfunnels_tiktok_protein50_popup_orders	
	
	/* OMG */
-- 	clickfunnels_omg_other_youtube_popup_orders
-- 	clickfunnels_omg_pkit4_youtube_orders
-- 	clickfunnels_omg_shopping_pmax_popup_orders
	
-- WHERE
-- 	DATE(created_at_pst )::date >= MAKE_DATE (2023, 03, 01) 
-- 	AND DATE(created_at_pst )::date <= MAKE_DATE (2023, 01, 19) 
GROUP BY
	date_pst
ORDER BY
	date_pst DESC