SELECT
	COALESCE(tiktok_protein50_shopify.date_pst, tiktok_protein50_popup.date_pst) AS date_pst,
	COALESCE(tiktok_protein50_shopify.total, 0) AS standard_revenue,
	COALESCE(tiktok_protein50_shopify.order_count, 0) AS standard_order_count,
	COALESCE(tiktok_protein50_popup.revenue, 0) AS popup_revenue,
	COALESCE(tiktok_protein50_popup.order_count, 0) AS popup_order_count,
	(COALESCE(tiktok_protein50_shopify.total, 0) + COALESCE(tiktok_protein50_popup.revenue, 0)) AS total_revenue,
	(COALESCE(tiktok_protein50_shopify.order_count, 0) + COALESCE(tiktok_protein50_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_tiktok_protein50_revenue_orders_daily AS tiktok_protein50_shopify
	FULL JOIN "public".clickfunnels_tiktok_protein50_popup_revenue_orders_daily AS tiktok_protein50_popup USING (date_pst)
-- WHERE 
-- 	(COALESCE(tiktok_protein50_shopify.date_pst, tiktok_protein50_popup.date_pst) >= MAKE_DATE (2023, 02, 09))
-- 	AND(COALESCE(tiktok_protein50_shopify.date_pst, tiktok_protein50_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC