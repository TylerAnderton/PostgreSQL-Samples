SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:fb-collagen-promo(,|$)|utm:campaign:attn_(abo_collagen50|protein50_abo_collagen|protein50_cbo_collagen)'  
    AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC