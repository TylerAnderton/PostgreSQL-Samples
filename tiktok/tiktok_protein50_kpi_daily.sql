 SELECT COALESCE(tiktok_protein50_spend.stat_date, tiktok_protein50_revenue_orders.date_pst) AS date_,
    COALESCE(tiktok_protein50_spend.spend, 0::numeric) AS spend,
    COALESCE(tiktok_protein50_revenue_orders.standard_revenue, 0::numeric) AS standard_revenue,
    COALESCE(tiktok_protein50_revenue_orders.standard_order_count, 0::bigint) AS standard_order_count,
    COALESCE(tiktok_protein50_revenue_orders.popup_revenue, 0::numeric) AS popup_revenue,
    COALESCE(tiktok_protein50_revenue_orders.popup_order_count, 0::bigint) AS popup_order_count,
    COALESCE(tiktok_protein50_revenue_orders.total_revenue, 0::numeric) AS total_revenue,
    COALESCE(tiktok_protein50_revenue_orders.total_order_count, 0::bigint) AS total_order_count,
    round(COALESCE(tiktok_protein50_revenue_orders.total_revenue, 0::numeric) / COALESCE(tiktok_protein50_spend.spend, 0::numeric), 2) AS roas,
    round(COALESCE(tiktok_protein50_revenue_orders.total_revenue, 0::numeric) / COALESCE(tiktok_protein50_revenue_orders.total_order_count, 0::bigint)::numeric, 2) AS aov,
    round(COALESCE(tiktok_protein50_spend.spend, 0::numeric) / COALESCE(tiktok_protein50_revenue_orders.total_order_count, 0::bigint)::numeric, 2) AS cpa
   FROM tiktok_protein50_ad_spend_daily tiktok_protein50_spend
     JOIN combo_tiktok_protein50_revenue_orders_daily tiktok_protein50_revenue_orders ON tiktok_protein50_spend.stat_date = tiktok_protein50_revenue_orders.date_pst
  ORDER BY (COALESCE(tiktok_protein50_spend.stat_date, tiktok_protein50_revenue_orders.date_pst)) DESC;