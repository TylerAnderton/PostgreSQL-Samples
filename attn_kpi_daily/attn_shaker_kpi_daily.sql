 SELECT COALESCE(facebook_shaker_spend.date_start, facebook_shaker_revenue_orders.date_pst) AS date_,
    round(COALESCE(facebook_shaker_spend.spend, 0::numeric::double precision)::numeric, 2) AS spend,
    COALESCE(facebook_shaker_revenue_orders.standard_revenue, 0::numeric) AS standard_revenue,
    COALESCE(facebook_shaker_revenue_orders.standard_order_count, 0::bigint) AS standard_order_count,
    COALESCE(facebook_shaker_revenue_orders.popup_revenue, 0::numeric) AS popup_revenue,
    COALESCE(facebook_shaker_revenue_orders.popup_order_count, 0::bigint) AS popup_order_count,
    COALESCE(facebook_shaker_revenue_orders.total_revenue, 0::numeric) AS total_revenue,
    COALESCE(facebook_shaker_revenue_orders.total_order_count, 0::bigint) AS total_order_count,
    round((COALESCE(facebook_shaker_revenue_orders.total_revenue, 0::numeric)::double precision / facebook_shaker_spend.spend)::numeric, 2) AS roas,
    round(COALESCE(facebook_shaker_revenue_orders.total_revenue, 0::numeric) / facebook_shaker_revenue_orders.total_order_count::numeric, 2) AS aov,
    round((COALESCE(facebook_shaker_spend.spend, 0::numeric::double precision) / facebook_shaker_revenue_orders.total_order_count::double precision)::numeric, 2) AS cpa
   FROM facebook_shaker_spend_daily facebook_shaker_spend
     FULL JOIN combo_shaker_revenue_orders_daily facebook_shaker_revenue_orders ON facebook_shaker_spend.date_start = facebook_shaker_revenue_orders.date_pst
  ORDER BY (COALESCE(facebook_shaker_spend.date_start, facebook_shaker_revenue_orders.date_pst)) DESC;