WITH sample AS (
	SELECT 
		COALESCE(pkit4.date_, pkit6.date_, pkit7.date_, bkit4.date_, bkit6.date_, collagen_sms.date_, pkit_bkit.date_, pkit_bkit_shaker.date_) AS date,
		
		COALESCE(SUM(pkit4.spend), 0) + COALESCE(SUM(pkit6.spend), 0) + COALESCE(SUM(pkit7.spend), 0) + COALESCE(SUM(bkit4.spend), 0) + COALESCE(SUM(bkit6.spend), 0) + COALESCE(SUM(collagen_sms.spend), 0) + COALESCE(SUM(pkit_bkit.spend), 0) + COALESCE(SUM(pkit_bkit_shaker.spend), 0) AS spend,
		
		COALESCE(SUM(pkit4.revenue), 0) + COALESCE(SUM(pkit6.revenue), 0) + COALESCE(SUM(pkit7.revenue), 0) + COALESCE(SUM(bkit4.revenue), 0) + COALESCE(SUM(bkit6.revenue), 0) + COALESCE(SUM(collagen_sms.revenue), 0) + COALESCE(SUM(pkit_bkit.revenue), 0) + COALESCE(SUM(pkit_bkit_shaker.revenue), 0) AS revenue,
		
		COALESCE(SUM(pkit4.order_count), 0) + COALESCE(SUM(pkit6.order_count), 0) + COALESCE(SUM(pkit7.order_count), 0) + COALESCE(SUM(bkit4.order_count), 0) + COALESCE(SUM(bkit6.order_count), 0) + COALESCE(SUM(collagen_sms.order_count), 0) + COALESCE(SUM(pkit_bkit.order_count), 0) + COALESCE(SUM(pkit_bkit_shaker.order_count), 0) AS order_count
		
	FROM 
		attn_pkit4_kpi_daily AS pkit4
	FULL JOIN
		attn_pkit6_kpi_daily AS pkit6
		USING (date_)
	FULL JOIN
		attn_pkit7_kpi_daily AS pkit7
		USING (date_)
	FULL JOIN
		attn_bkit4_kpi_daily AS bkit4
		USING (date_)
	FULL JOIN
		attn_bkit6_kpi_daily AS bkit6
		USING (date_)
	FULL JOIN
		attn_collagen_sms_kpi_daily AS collagen_sms
		USING (date_)
	FULL JOIN
		attn_pkit_bkit_kpi_daily AS pkit_bkit
		USING (date_)
	FULL JOIN
		attn_pkit_bkit_shaker_kpi_daily AS pkit_bkit_shaker
		USING (date_)
		
	GROUP BY
		date
)

SELECT
	*,
	CASE WHEN spend = 0 THEN NULL ELSE ROUND((revenue / spend)::NUMERIC, 2) END AS roas,
	CASE WHEN order_count = 0 THEN NULL ELSE ROUND((revenue / order_count)::NUMERIC, 2) END AS aov,
	CASE WHEN order_count = 0 THEN NULL ELSE ROUND((spend / order_count)::NUMERIC, 2) END AS cpa
FROM 
	sample
ORDER BY
	date DESC