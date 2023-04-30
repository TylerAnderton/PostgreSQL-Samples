SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:display-protein-promo(,|$)'
	AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC