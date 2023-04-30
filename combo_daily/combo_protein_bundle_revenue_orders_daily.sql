SELECT
	COALESCE(protein_bundle_shopify.date_pst, protein_bundle_cf.date_pst) AS date_pst,
	COALESCE(protein_bundle_shopify.total, 0) + COALESCE(protein_bundle_cf.revenue, 0) AS standard_revenue,
	COALESCE(protein_bundle_shopify.order_count, 0) + COALESCE(protein_bundle_cf.order_count, 0) AS standard_order_count,
	0.00 AS popup_revenue,
	0 AS popup_order_count,
	(COALESCE(protein_bundle_shopify.total, 0) + COALESCE(protein_bundle_cf.revenue, 0)) AS total_revenue,
	(COALESCE(protein_bundle_shopify.order_count, 0) + COALESCE(protein_bundle_cf.order_count, 0)) AS total_order_count
FROM
	"public".shopify_protein_bundle_revenue_orders_daily AS protein_bundle_shopify
	FULL JOIN "public".clickfunnels_protein_bundle_revenue_orders_daily AS protein_bundle_cf USING (date_pst)
-- WHERE (COALESCE(protein_bundle_shopify.date_pst, protein_bundle_cf.date_pst) >= MAKE_DATE (2022, 08, 01))
-- 	AND(COALESCE(protein_bundle_shopify.date_pst, protein_bundle_cf.date_pst) <= MAKE_DATE (2023, 01, 19))
ORDER BY
date_pst DESC