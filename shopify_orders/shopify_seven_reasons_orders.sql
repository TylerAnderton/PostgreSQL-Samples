SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:fb-article-shaker-promo|utm:campaign:attn-7-reasons'  
    AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC