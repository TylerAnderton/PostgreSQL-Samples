SELECT 
	*
FROM 
	"public".shopify_orders
WHERE

	discount_codes @> ANY(ARRAY[
		'[{"code": "IVEY20"}]'::jsonb,
		'[{"code": "STEPH"}]'::jsonb,
		'[{"code": "KAYLA20"}]'::jsonb,
		'[{"code": "KELSI"}]'::jsonb,
		'[{"code": "KAYLA"}]'::jsonb,
		'[{"code": "ELLA"}]'::jsonb,
		'[{"code": "DANI"}]'::jsonb,
		'[{"code": "THANDI"}]'::jsonb,
		'[{"code": "JULIE"}]'::jsonb,
		'[{"code": "CLAIRE"}]'::jsonb,
		'[{"code": "IDA"}]'::jsonb,
		'[{"code": "MARY"}]'::jsonb,
		'[{"code": "Noelia"}]'::jsonb,
		'[{"code": "NIKKI"}]'::jsonb,
		'[{"code": "EMILY"}]'::jsonb
	])
	
	AND tags !~* 'subscription recurring order'
	
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 01, 01) 
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 04, 10)
	
ORDER BY
	created_at DESC