SELECT
	COALESCE(shopping_pmax_shopify.date_pst, shopping_pmax_popup.date_pst) AS date_pst,
	COALESCE(shopping_pmax_shopify.total, 0) AS standard_revenue,
	COALESCE(shopping_pmax_shopify.order_count, 0) AS standard_order_count,
	COALESCE(shopping_pmax_popup.revenue, 0) AS popup_revenue,
	COALESCE(shopping_pmax_popup.order_count, 0) AS popup_order_count,
	(COALESCE(shopping_pmax_shopify.total, 0) + COALESCE(shopping_pmax_popup.revenue, 0)) AS total_revenue,
	(COALESCE(shopping_pmax_shopify.order_count, 0) + COALESCE(shopping_pmax_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_omg_shopping_pmax_revenue_orders_daily  AS shopping_pmax_shopify
	FULL JOIN "public".clickfunnels_omg_shopping_pmax_revenue_orders_daily AS shopping_pmax_popup USING (date_pst)
-- WHERE (COALESCE(shopping_pmax_shopify.date_pst, shopping_pmax_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(shopping_pmax_shopify.date_pst, shopping_pmax_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC