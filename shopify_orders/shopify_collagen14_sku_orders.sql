SELECT
	*
FROM 
	"public".shopify_orders
WHERE

	line_items @> ANY(ARRAY[
		'[{"sku": "COLLAGEN14P"}]'::jsonb
	])
	
	AND tags !~* 'subscription recurring order'
	AND name !~* '[A-Z]' -- exclude cancelled/edited orders
	
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 04, 01) 
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date = MAKE_DATE(2023, 04, 11)
ORDER BY
	created_at DESC