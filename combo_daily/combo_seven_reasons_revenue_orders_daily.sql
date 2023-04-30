SELECT
	COALESCE(seven_reasons_shopify.date_pst, seven_reasons_popup.date_pst) AS date_pst,
	COALESCE(seven_reasons_shopify.total, 0) AS standard_revenue,
	COALESCE(seven_reasons_shopify.order_count, 0) AS standard_order_count,
	COALESCE(seven_reasons_popup.revenue, 0) AS popup_revenue,
	COALESCE(seven_reasons_popup.order_count, 0) AS popup_order_count,
	(COALESCE(seven_reasons_shopify.total, 0) + COALESCE(seven_reasons_popup.revenue, 0)) AS total_revenue,
	(COALESCE(seven_reasons_shopify.order_count, 0) + COALESCE(seven_reasons_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_seven_reasons_revenue_orders_daily AS seven_reasons_shopify
	FULL JOIN "public".clickfunnels_seven_reasons_popup_revenue_orders_daily AS seven_reasons_popup USING (date_pst)
-- WHERE (COALESCE(seven_reasons_shopify.date_pst, seven_reasons_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(seven_reasons_shopify.date_pst, seven_reasons_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC