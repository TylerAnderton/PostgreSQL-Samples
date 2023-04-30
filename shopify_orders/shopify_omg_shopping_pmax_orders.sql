SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'utm:medium:shopping(,|$)|utm:campaign:pmax(,|$)|promo:google-shopping(,|$)|utm:campaign:shopping(,|$)'
	AND tags !~* 'subscription recurring order|bing'
ORDER BY
	created_at DESC