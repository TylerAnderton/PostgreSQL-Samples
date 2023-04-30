SELECT
	COALESCE(challenge_shopify.date_pst, challenge_popup.date_pst) AS date_pst,
	COALESCE(challenge_shopify.total, 0) AS standard_revenue,
	COALESCE(challenge_shopify.order_count, 0) AS standard_order_count,
	COALESCE(challenge_popup.revenue, 0) AS popup_revenue,
	COALESCE(challenge_popup.order_count, 0) AS popup_order_count,
	(COALESCE(challenge_shopify.total, 0) + COALESCE(challenge_popup.revenue, 0)) AS total_revenue,
	(COALESCE(challenge_shopify.order_count, 0) + COALESCE(challenge_popup.order_count, 0)) AS total_order_count
FROM
	"public".shopify_challenge_revenue_orders_daily AS challenge_shopify
	FULL JOIN "public".clickfunnels_challenge_popup_revenue_orders_daily AS challenge_popup USING (date_pst)
-- WHERE (COALESCE(challenge_shopify.date_pst, challenge_popup.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(challenge_shopify.date_pst, challenge_popup.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
	date_pst DESC