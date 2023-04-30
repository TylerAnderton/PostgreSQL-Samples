SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:fb-shaker-promo(,|$)|utm:campaign:attn-shaker-(,|$|promo(,|$|-kate|-cbo)|cbo)|utm:campaign:attn_shaker_(cbo_lto|broad)'  
    AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC