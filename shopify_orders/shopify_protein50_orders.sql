SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:fb-protein-promo(,|$)|utm:campaign:attn_cp_protein50_cbo|utm:campaign:attn_protein50(,|$)|utm:campaign:attn-protein50-influencers|utm:campaign:attn_protein50_(fb|remarketing|aug|rmkt_harmon|cbo(,|$)|main|cbo_lto_test|bfcm_asc|main_1daycli|cbo4|cbo3|bfcm|bfcm_cbo|cbo_lto|cbo_lto_nye|gut|gut_1dayclic|main_costcap|main_influen|nye_asc|old_june|cbo_lto_vday|cbo_testing|sweetsvid|cbo_vchai|cbo_eryth|8kit|asc_testing|creative_tes|cbo_rule|21|asc_atw|cbo_atw)'
    AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC