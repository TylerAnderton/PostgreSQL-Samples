 SELECT tiktok_ad_spend_daily.stat_date,
    sum(tiktok_ad_spend_daily.spend) AS spend
   FROM tiktok_ad_spend_daily
--   WHERE tiktok_ad_spend_daily.ad_name ~* 'protein50'::text -- temporarily including all TikTok spend for protein50
  GROUP BY tiktok_ad_spend_daily.stat_date
  	HAVING sum(tiktok_ad_spend_daily.spend) <> 0::numeric
  ORDER BY tiktok_ad_spend_daily.stat_date DESC;