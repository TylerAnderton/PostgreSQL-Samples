SELECT 
	date_start,
	SUM(spend) AS spend
FROM 
	fb_ads_ads_insights_view AS fb_ads_ads_insights
WHERE
	spend <> 0
-- 	AND date_start >= MAKE_DATE(2023, 03, 15)
	AND campaign_name ~* 'attn'
	
	AND campaign_name ~* 'protein50'
-- 	AND campaign_name ~* 'shaker'
-- 	AND campaign_name ~* 'challenge'
-- 	AND campaign_name ~* 'collagen50'
-- 	AND campaign_name ~* 'collagen sms'
-- 	AND campaign_name ~* 'flash sale'
-- 	AND campaign_name ~* 'proteinbundle'

-- 	AND campaign_name ~* 'pkit4'
-- 	AND campaign_name ~* 'pkit6'
-- 	AND campaign_name ~* 'pkit7'
-- 	AND campaign_name ~* 'bkit4'
-- 	AND campaign_name ~* 'bkit6'

-- 	AND (campaign_name ~* 'pkit-bkit' AND campaign_name !~* 'shaker')
-- 	AND campaign_name ~* 'pkit-bkit-shaker'
	
GROUP BY 
	date_start
ORDER BY
	date_start DESC