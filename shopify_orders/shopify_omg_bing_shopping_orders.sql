SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* '(utm:medium:shopping(,|$)|utm:campaign:pmax(,|$)|promo:google-shopping(,|$)|utm:campaign:shopping(,|$))((?=.*bing.*)|(?<=.*bing.*))'
	AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC