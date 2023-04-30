SELECT
	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date AS date_pst,
	ROUND(SUM(total_price)::numeric, 2) AS total,
	COUNT(*) AS order_count
FROM
	"public".shopify_orders
WHERE
-- 	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2022, 08, 01) 
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 01, 19)
-- 	AND 
	tags ~* 'promo:fb-protein-promo(,|$)|utm:campaign:attn_cp_protein50_cbo|utm:campaign:attn_protein50(,|$)|utm:campaign:attn-protein50-influencers|utm:campaign:attn_protein50_(fb39|fb23|remarketing|fb39_ig_stor|fb28|fb83|fb32|fb24|fb87|aug|fb_d|rmkt_harmon|cbo|main|cbo_lto_test|bfcm_asc|main_1daycli|cbo4|fb39_reel_cb|cbo3|bfcm|bfcm_cbo|cbo_lto|cbo_lto_nye|gut|gut_1dayclic|main_costcap|main_influen|nye_asc|old_june|cbo_lto_vday|cbo_testing-|sweetsvid|cbo_vchai)'
	AND tags !~* 'subscription recurring order'
GROUP BY
	date_pst 
ORDER BY
	date_pst DESC