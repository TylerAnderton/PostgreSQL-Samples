SELECT
	*
FROM 
	"public".shopify_orders
WHERE
	(
		tags ~* 'promo:tiktok-protein-promo(,|$)|code:AMANDA20(,|$)'
		OR discount_codes @> '[{"code": "AMANDA20"}]'::jsonb
	)
	
	AND tags !~* 'subscription recurring order'
	
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 04, 01)
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 04, 10)
ORDER BY
	created_at DESC