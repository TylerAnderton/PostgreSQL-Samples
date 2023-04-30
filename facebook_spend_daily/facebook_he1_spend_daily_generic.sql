SELECT 
	date_start,
	SUM(spend) AS spend
FROM 
	fb_he1_ads_insights_view AS fb_he1_ads_insights
WHERE
	spend <> 0
-- 	AND date_start >= MAKE_DATE(2023, 03, 15)
	AND campaign_name ~* 'attn'
	
	AND campaign_name ~* '7 reasons'
	
GROUP BY 
	date_start
ORDER BY
	date_start DESC