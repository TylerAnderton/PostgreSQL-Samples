SELECT
	*
FROM 
	"public".shopify_orders
WHERE
	(
        tags ~* 'utm:campaign:attn-25off(,|$)|code:25off(,|$)'
        OR discount_codes @> ANY(ARRAY[
			'[{"code": "25off"}]'::jsonb,
			'[{"code": "FLASHSALE25"}]'::jsonb
		])
	
	)
	
	AND tags !~* 'subscription recurring order'
	
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 04, 01)
ORDER BY
	created_at DESC