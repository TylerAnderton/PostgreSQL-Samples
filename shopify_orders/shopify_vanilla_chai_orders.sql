SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'pn:protein-package-fb(105|111)'
	AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC