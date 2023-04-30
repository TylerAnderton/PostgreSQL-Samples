 SELECT COALESCE(facebook_twenty_five_off_spend.date_start, facebook_twenty_five_off_revenue_orders.date_pst) AS date_,
    round(COALESCE(facebook_twenty_five_off_spend.spend, 0::numeric)::numeric, 2) AS spend,
    COALESCE(facebook_twenty_five_off_revenue_orders.total, 0::numeric) AS revenue,
    COALESCE(facebook_twenty_five_off_revenue_orders.order_count, 0::bigint) AS order_count,
    round((COALESCE(facebook_twenty_five_off_revenue_orders.total::numeric, 0::numeric) / facebook_twenty_five_off_spend.spend)::numeric, 2) AS roas,
    round(COALESCE(facebook_twenty_five_off_revenue_orders.total::numeric, 0::numeric) / facebook_twenty_five_off_revenue_orders.order_count::numeric, 2) AS aov,
    round((COALESCE(facebook_twenty_five_off_spend.spend, 0::numeric) / facebook_twenty_five_off_revenue_orders.order_count::numeric)::numeric, 2) AS cpa
   FROM facebook_twenty_five_off_spend_daily facebook_twenty_five_off_spend
    FULL JOIN shopify_twenty_five_off_revenue_orders_daily facebook_twenty_five_off_revenue_orders ON facebook_twenty_five_off_spend.date_start = facebook_twenty_five_off_revenue_orders.date_pst
  ORDER BY (COALESCE(facebook_twenty_five_off_spend.date_start, facebook_twenty_five_off_revenue_orders.date_pst)) DESC;