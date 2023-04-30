SELECT
	COALESCE(shaker_shopify.date_pst, shaker_popup.date_pst) AS date_pst,
	COALESCE(shaker_shopify.total, 0) AS standard_revenue,
	COALESCE(shaker_shopify.order_count, 0) AS standard_order_count,
	COALESCE(shaker_popup.revenue, 0) AS popup_revenue,
	COALESCE(shaker_popup.order_count, 0) AS popup_order_count,
	(COALESCE(shaker_shopify.total, 0) + COALESCE(shaker_popup.revenue, 0)) AS total_revenue,
	(COALESCE(shaker_shopify.order_count, 0) + COALESCE(shaker_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_shaker_revenue_orders_daily AS shaker_shopify
	FULL JOIN "public".clickfunnels_shaker_popup_revenue_orders_daily AS shaker_popup USING (date_pst)
-- WHERE (COALESCE(shaker_shopify.date_pst, shaker_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(shaker_shopify.date_pst, shaker_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC