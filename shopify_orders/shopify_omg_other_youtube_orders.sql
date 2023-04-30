SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:yt-protein-promo(,|$|-pp)|promo:yt-bar-promo(,|$|-pp)|utm:source:youtube(,|$)'
	AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC