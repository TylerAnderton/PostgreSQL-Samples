SELECT
	COALESCE(collagen50_shopify.date_pst, collagen50_popup.date_pst) AS date_pst,
	COALESCE(collagen50_shopify.total, 0) AS standard_revenue,
	COALESCE(collagen50_shopify.order_count, 0) AS standard_order_count,
	COALESCE(collagen50_popup.revenue, 0) AS popup_revenue,
	COALESCE(collagen50_popup.order_count, 0) AS popup_order_count,
	(COALESCE(collagen50_shopify.total, 0) + COALESCE(collagen50_popup.revenue, 0)) AS total_revenue,
	(COALESCE(collagen50_shopify.order_count, 0) + COALESCE(collagen50_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_collagen50_revenue_orders_daily AS collagen50_shopify
	FULL JOIN "public".clickfunnels_collagen50_popup_revenue_orders_daily AS collagen50_popup USING (date_pst)
-- WHERE (COALESCE(collagen50_shopify.date_pst, collagen50_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(collagen50_shopify.date_pst, collagen50_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC