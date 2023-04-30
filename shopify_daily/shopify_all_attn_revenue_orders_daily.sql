SELECT
	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date AS date_pst,
	ROUND(SUM(total_price)::numeric, 2) AS total,
	COUNT(*) AS order_count
FROM

	shopify_orders_view

	/* ATTN */
-- 	shopify_protein50_orders
-- 	shopify_shaker_orders
--	shopify_challenge_orders
-- 	shopify_seven_reasons_orders
-- 	shopify_vanilla_chai_orders
-- 	shopify_collagen50_orders
-- 	shopify_twenty_five_off_orders

	/* TIKTOK */
-- 	shopify_tiktok_protein50_orders

	/* OMG */
-- 	shopify_omg_bing_shopping_orders
-- 	shopify_omg_discovery_orders
-- 	shopify_omg_other_youtube_orders
-- 	shopify_omg_shopping_pmax_orders

	/* INFLUENCERS */
-- 	shopify_influencer_code_orders

WHERE
	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2022, 11, 01) 
	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 03, 31)
	
	AND tags !~* 'subscription recurring order'
	
	/* ALL ATTN REGEX */
	AND (
		-- protein50
		tags ~* 'promo:fb-protein-promo(,|$)|utm:campaign:attn_cp_protein50_cbo|utm:campaign:attn_protein50(,|$)|utm:campaign:attn-protein50-influencers|utm:campaign:attn_protein50_(fb|remarketing|aug|rmkt_harmon|cbo(,|$)|main|cbo_lto_test|bfcm_asc|main_1daycli|cbo4|cbo3|bfcm|bfcm_cbo|cbo_lto|cbo_lto_nye|gut|gut_1dayclic|main_costcap|main_influen|nye_asc|old_june|cbo_lto_vday|cbo_testing|sweetsvid|cbo_vchai|cbo_eryth|8kit|asc_testing|creative_tes|cbo_rule|21)'
		OR
		-- shaker
		tags ~* 'promo:fb-shaker-promo(,|$)|utm:campaign:attn-shaker-(,|$|promo(,|$|-kate|-cbo)|cbo)|utm:campaign:attn_shaker_(cbo_lto|broad)'
		OR
		-- challenge
		tags ~* 'promo:fb-protein-challenge(,|$)|utm:campaign:attn_protein50_challenge(,|$|_cb)|utm:campaign:attn_protein_challenge_rmkt'
		OR
		-- 7 reasons
		tags ~* 'promo:fb-article-shaker-promo|utm:campaign:attn-7-reasons'
		OR
		-- energy
		tags ~* 'promo:fb-protein-energy|utm:campaign:protein-energy-attn'
		OR
		-- awareness
		tags ~* 'promo:fb-protein-promo-(la|chicago)'
		OR
		-- vanilla chai
		tags ~* 'pn:protein-package-fb(105|111)'
		OR
		-- collagen50
		tags ~* 'promo:fb-collagen-promo(,|$)|utm:campaign:attn_(abo_collagen50|protein50_abo_collagen|protein50_cbo_collagen)'
		OR
		-- 25off
		(
            tags ~* 'utm:campaign:attn-25off(,|$)|code:25off(,|$)'
        	OR discount_codes @> ANY(ARRAY[
				'[{"code": "25off"}]'::jsonb,
				'[{"code": "FLASHSALE25"}]'::jsonb
            ])
        )
	)
	
GROUP BY
	date_pst 
ORDER BY
	date_pst DESC