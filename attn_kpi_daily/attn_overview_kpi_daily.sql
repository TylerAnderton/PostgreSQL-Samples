WITH overview AS (
	SELECT 
		COALESCE(full_size.date, sample.date) AS date,
		COALESCE(SUM(full_size.spend), 0) + COALESCE(SUM(sample.spend), 0) AS spend,
		COALESCE(SUM(full_size.standard_revenue), 0) + COALESCE(SUM(sample.revenue), 0) AS standard_revenue,
		COALESCE(SUM(full_size.standard_order_count), 0) + COALESCE(SUM(sample.order_count), 0) AS standard_order_count,
		COALESCE(SUM(full_size.popup_revenue), 0) AS popup_revenue,
		COALESCE(SUM(full_size.popup_order_count), 0) AS popup_order_count,
		COALESCE(SUM(full_size.total_revenue), 0) + COALESCE(SUM(sample.revenue), 0) AS total_revenue,
		COALESCE(SUM(full_size.total_order_count), 0) + COALESCE(SUM(sample.order_count), 0) AS total_order_count
	FROM 
		attn_full_size_kpi_daily AS full_size
	FULL JOIN
		attn_sample_kpi_daily AS sample
		USING (date)
	GROUP BY
		date
)

SELECT 
	*,
	CASE WHEN spend = 0 THEN NULL ELSE ROUND((total_revenue / spend)::NUMERIC, 2) END AS roas,
	CASE WHEN total_order_count = 0 THEN NULL ELSE ROUND((total_revenue / total_order_count)::NUMERIC, 2) END AS aov,
	CASE WHEN total_order_count = 0 THEN NULL ELSE ROUND((spend / total_order_count)::NUMERIC, 2) END AS cpa
FROM
	overview
ORDER BY
	date DESC