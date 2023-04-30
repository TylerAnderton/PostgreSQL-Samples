 SELECT DISTINCT dimensions.stat_time_day::date AS stat_date,
    round(metrics.spend::numeric, 2) AS spend,
    metrics.ad_name,
    metrics.adgroup_name AS ad_group,
    metrics.campaign_name
   FROM tiktok_ads_ads_reports_daily_dimensions_view dimensions
     JOIN tiktok_ads_ads_reports_daily_metrics_view metrics USING (_airbyte_tiktok_ads____reports_daily_hashid)
  ORDER BY (dimensions.stat_time_day::date) DESC, metrics.ad_name