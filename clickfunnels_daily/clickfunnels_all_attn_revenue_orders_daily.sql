SELECT
	DATE(created_at_pst) AS date_pst,
	SUM(total) AS revenue
FROM

	clickfunnel_orders_all_time_view_view

	/* ATTN */
-- 	clickfunnels_protein50_popup_orders
-- 	clickfunnels_shaker_popup_orders
-- 	clickfunnels_challenge_popup_orders
-- 	clickfunnels_seven_reasons_popup_orders
-- 	clickfunnels_collagen50_popup_orders
-- 	clickfunnels_collagen_sms_orders
-- 	clickfunnels_pkit4_orders
-- 	clickfunnels_pkit6_orders
-- 	clickfunnels_pkit7_orders
-- 	clickfunnels_bkit4_orders
-- 	clickfunnels_bkit6_orders

	/* TIKTOK */
-- 	clickfunnels_tiktok_protein50_popup_orders	
	
	/* OMG */
-- 	clickfunnels_omg_other_youtube_popup_orders
-- 	clickfunnels_omg_pkit4_youtube_orders
-- 	clickfunnels_omg_shopping_pmax_popup_orders
	
WHERE
	DATE(created_at_pst )::date >= MAKE_DATE (2022, 11, 01) 
	AND DATE(created_at_pst )::date <= MAKE_DATE (2023, 03, 31) 
	
	/* ALL ATTN UTMs */
	AND (
	
		/* POPUPS */
		-- protein50
		LOWER(utm_term) IN (
	      'pkit-4-protein50-popup', 'pkit-4-protein50-popup-followup', 'pkit-4-protein50-popup-vc', 'pkit-4-protein50-popup-vc-followup'
	    )
	    OR
	    
	    -- shaker
	    LOWER(utm_term) IN (
	      'pkit-4-shaker-popup', 'shaker-free-shipping-popup', 'pkit-4-protein50-popup-shaker', 'shaker-free-shipping-popup-cold-followup'
	    )
	    OR
	    
	    -- challenge
	    LOWER(utm_term) IN (
	      'pkit-4-protein50-popup-challenge', 'pkit-4-protein50-popup-challenge-followup'
	    )
	    OR
	    
	    -- 7 reasons
	    LOWER(utm_term) IN (
	      'pkit-4-p50-article-popup'
	    )
	    OR
	    
	    -- collagen50
	    LOWER(utm_term) IN (
	      'collagen14-c50-popup', 'collagen14-c50-popup-followup'
	    )
	    OR
	    
	    -- awareness
	    LOWER(utm_term) IN (
	      'pkit-4-protein50-popup-awareness'
	    )
	    OR
	    
	    -- vanilla chai
	    LOWER(utm_term) IN (
	      'pkit-4-protein50-popup-vc', 'pkit-4-protein50-popup-vc-followup'
	    )
	    OR
	    
	    
	    /* DISCONTINUED OFFERS */
	    -- shaker sms
	    LOWER(utm_term) IN (
	      'shaker-free-shipping'
	    )
	    OR
	    
	    -- vckit3
	    LOWER(utm_term) IN (
	      'vckit-3-free-shipping', 'vckit-3-free-shipping-followup'
	    )
	    OR
	    
	    -- pbkit3
	    LOWER(utm_term) IN (
	      'pbkit-3-free-shipping-attn', 'pbkit-3-free-shipping-followup-attn'
	    )
	    OR
	    
	    -- chkit3
	    LOWER(utm_term) IN (
	      'chkit-3-free-shipping', 'chkit-3-free-shipping-followup-fb'
	    )
	    OR
	    
	    -- vkit3
	    LOWER(utm_term) IN (
	      'vkit-3-free-shipping', 'vkit-3-free-shipping-followup-fb'
	    )
	    OR
	    
	    -- cpbkit3
	    LOWER(utm_term) IN (
	      'cpbkit-3-free-shipping', 'cpbkit-3-free-shipping-followup-fb'
	    )
	    OR
	    
	    -- bckit3
	    LOWER(utm_term) IN (
	      'bckit-3-free-shipping', 'bckit-3-free-shipping-followup-fb'
	    )
	    OR
	    
	    -- PKIT4 STC
	    LOWER(utm_campaign) IN (
	      'pkit-4-stc-free-shipping'
	    )
	    OR
	    
	    -- PKIT-4-SHAKER
	    LOWER(utm_term) IN (
	      'pkit-4-shaker-free-shipping'
	    )
	    OR
	    
	    -- PKIT4-PAID
	    LOWER(utm_term) IN (
	      'pkit-4-sample-pack-paid'
	    )
	    OR
	    
	    -- PKIT6 LP
	    LOWER(utm_campaign) IN (
	      'attn_6kit_fb_lp'
	    )
	    OR
	    
	    /* CURRENT OFFERS */
	    -- PKIT4
	    (
	      LOWER(utm_term) IN (
	        'pkit-4-free-shipping', 'pkit-4-bridge'
	      )
	      OR LOWER(utm_term) LIKE 'pkit-4-free-shipping-followup-fb-%'
	      OR LOWER(utm_term) LIKE 'pkit-4-free-shipping-var%'
	    )
	    OR
	    
	    -- PKIT6
	    LOWER(utm_term) IN (
	      'pkit-6-sample-pack', 'pkit-6-sample-pack-cold-followup'
	    )
	    OR
	    
	    -- PKIT7
	    LOWER(utm_term) IN (
	      'pkit-7-sample-pack-attn', 'pkit-7-sample-pack-cold-followup'
	    )
	    OR
	    
	    -- BKIT4
	    LOWER(utm_term) IN (
	      'bkit-4-free-shipping', 'bkit-4-free-shipping-ob2', 'bkit-4-free-shipping-ob3', 'bkit-4-free-shipping-followup-fb'
	    )
	    OR
	    
	    -- BKIT6
	    LOWER(utm_term) IN (
	      'bkit-6-free-shipping-attn', 'bkit-6-free-shipping-cold-followup'
	    )
	    OR
	    
	    -- collagen sms
	    utm_term IN ('collagen14-attn', 'collagen14-attn-followup')
	    
	)
GROUP BY
	date_pst
ORDER BY
	date_pst DESC