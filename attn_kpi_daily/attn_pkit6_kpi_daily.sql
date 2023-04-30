 SELECT COALESCE(facebook_pkit6_spend.date_start, facebook_pkit6_revenue_orders.date_pst) AS date_,
    round(COALESCE(facebook_pkit6_spend.spend, 0::numeric)::numeric, 2) AS spend,
    COALESCE(facebook_pkit6_revenue_orders.revenue, 0::numeric) AS revenue,
    COALESCE(facebook_pkit6_revenue_orders.order_count, 0::bigint) AS order_count,
    round((COALESCE(facebook_pkit6_revenue_orders.revenue::numeric, 0::numeric) / facebook_pkit6_spend.spend)::numeric, 2) AS roas,
    round(COALESCE(facebook_pkit6_revenue_orders.revenue::numeric, 0::numeric) / facebook_pkit6_revenue_orders.order_count::numeric, 2) AS aov,
    round((COALESCE(facebook_pkit6_spend.spend, 0::numeric) / facebook_pkit6_revenue_orders.order_count::numeric)::numeric, 2) AS cpa
   FROM facebook_pkit6_spend_daily facebook_pkit6_spend
   FULL JOIN clickfunnels_pkit6_revenue_orders_daily facebook_pkit6_revenue_orders ON facebook_pkit6_spend.date_start = facebook_pkit6_revenue_orders.date_pst
  ORDER BY (COALESCE(facebook_pkit6_spend.date_start, facebook_pkit6_revenue_orders.date_pst)) DESC;