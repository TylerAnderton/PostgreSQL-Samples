SELECT
	COALESCE(other_youtube_shopify.date_pst, other_youtube_popup.date_pst) AS date_pst,
	COALESCE(other_youtube_shopify.total, 0) AS standard_revenue,
	COALESCE(other_youtube_shopify.order_count, 0) AS standard_order_count,
	COALESCE(other_youtube_popup.revenue, 0) AS popup_revenue,
	COALESCE(other_youtube_popup.order_count, 0) AS popup_order_count,
	(COALESCE(other_youtube_shopify.total, 0) + COALESCE(other_youtube_popup.revenue, 0)) AS total_revenue,
	(COALESCE(other_youtube_shopify.order_count, 0) + COALESCE(other_youtube_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_omg_other_youtube_revenue_orders_daily  AS other_youtube_shopify
	FULL JOIN "public".clickfunnels_omg_other_youtube_revenue_orders_daily AS other_youtube_popup USING (date_pst)
-- WHERE (COALESCE(other_youtube_shopify.date_pst, other_youtube_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(other_youtube_shopify.date_pst, other_youtube_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC