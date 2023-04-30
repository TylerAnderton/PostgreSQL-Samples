SELECT
	*
FROM 
	"public".shopify_orders
WHERE
	discount_codes @> ANY(ARRAY[
		'[{"code": "PROTEINBUNDLE"}]'::jsonb,
		'[{"code": "PROTEIN-BUNDLE"}]'::jsonb
	])
	
	AND tags !~* 'subscription recurring order'
	
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 04, 01)
ORDER BY
	created_at DESC