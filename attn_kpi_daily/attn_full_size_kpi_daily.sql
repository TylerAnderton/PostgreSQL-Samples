WITH full_size AS (
	SELECT 
		COALESCE(protein50.date_, shaker.date_, challenge.date_, collagen50.date_, seven_reasons.date_, twenty_five_off.date_, protein_bundle.date_) AS date,
		
		COALESCE(SUM(protein50.spend), 0) + COALESCE(SUM(shaker.spend), 0) + COALESCE(SUM(challenge.spend), 0) + COALESCE(SUM(collagen50.spend), 0) + COALESCE(SUM(seven_reasons.spend), 0) + COALESCE(SUM(twenty_five_off.spend), 0) + COALESCE(SUM(protein_bundle.spend), 0) AS spend,
		
		COALESCE(SUM(protein50.standard_revenue), 0) + COALESCE(SUM(shaker.standard_revenue), 0) + COALESCE(SUM(challenge.standard_revenue), 0) + COALESCE(SUM(collagen50.standard_revenue), 0) + COALESCE(SUM(seven_reasons.standard_revenue), 0) + COALESCE(SUM(twenty_five_off.revenue), 0) + COALESCE(SUM(protein_bundle.standard_revenue), 0) AS standard_revenue,
		
		COALESCE(SUM(protein50.standard_order_count), 0) + COALESCE(SUM(shaker.standard_order_count), 0) + COALESCE(SUM(challenge.standard_order_count), 0) + COALESCE(SUM(collagen50.standard_order_count), 0) + COALESCE(SUM(seven_reasons.standard_order_count), 0) + COALESCE(SUM(twenty_five_off.order_count), 0) + COALESCE(SUM(protein_bundle.standard_order_count), 0) AS standard_order_count,
		
		COALESCE(SUM(protein50.popup_revenue), 0) + COALESCE(SUM(shaker.popup_revenue), 0) + COALESCE(SUM(challenge.popup_revenue), 0) + COALESCE(SUM(collagen50.popup_revenue), 0) + COALESCE(SUM(seven_reasons.popup_revenue), 0) + COALESCE(SUM(protein_bundle.popup_revenue), 0) AS popup_revenue,
		
		COALESCE(SUM(protein50.popup_order_count), 0) + COALESCE(SUM(shaker.popup_order_count), 0) + COALESCE(SUM(challenge.popup_order_count), 0) + COALESCE(SUM(collagen50.popup_order_count), 0) + COALESCE(SUM(seven_reasons.popup_order_count), 0) + COALESCE(SUM(protein_bundle.popup_order_count), 0) AS popup_order_count,
		
		COALESCE(SUM(protein50.total_revenue), 0) + COALESCE(SUM(shaker.total_revenue), 0) + COALESCE(SUM(challenge.total_revenue), 0) + COALESCE(SUM(collagen50.total_revenue), 0) + COALESCE(SUM(seven_reasons.total_revenue), 0) + COALESCE(SUM(twenty_five_off.revenue), 0) + COALESCE(SUM(protein_bundle.standard_revenue), 0) AS total_revenue,
		
		COALESCE(SUM(protein50.total_order_count), 0) + COALESCE(SUM(shaker.total_order_count), 0) + COALESCE(SUM(challenge.total_order_count), 0) + COALESCE(SUM(collagen50.total_order_count), 0) + COALESCE(SUM(seven_reasons.total_order_count), 0) + COALESCE(SUM(twenty_five_off.order_count), 0) + COALESCE(SUM(protein_bundle.standard_order_count), 0) AS total_order_count
		
	FROM 
		attn_protein50_kpi_daily AS protein50
	FULL JOIN
		attn_shaker_kpi_daily AS shaker
		USING (date_)
	FULL JOIN
		attn_challenge_kpi_daily AS challenge
		USING (date_)
	FULL JOIN
		attn_collagen50_kpi_daily AS collagen50
		USING (date_)
	FULL JOIN
		attn_seven_reasons_kpi_daily AS seven_reasons
		USING (date_)
	FULL JOIN
		attn_twenty_five_off_kpi_daily AS twenty_five_off
		USING (date_)
	FULL JOIN
		attn_protein_bundle_kpi_daily AS protein_bundle
		USING (date_)

	GROUP BY
		date
)

SELECT
	*,
	CASE WHEN spend = 0 THEN NULL ELSE ROUND((total_revenue / spend)::NUMERIC, 2) END AS roas,
	CASE WHEN total_order_count = 0 THEN NULL ELSE ROUND((total_revenue / total_order_count)::NUMERIC, 2) END AS aov,
	CASE WHEN total_order_count = 0 THEN NULL ELSE ROUND((spend / total_order_count)::NUMERIC, 2) END AS cpa
FROM 
	full_size
ORDER BY
	date DESC