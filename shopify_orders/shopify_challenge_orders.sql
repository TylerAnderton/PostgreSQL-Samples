SELECT
	*
FROM 
	"public".shopify_orders 
WHERE
	tags ~* 'promo:fb-protein-challenge(,|$)|utm:campaign:attn_protein50_challenge(,|$|_cb)|utm:campaign:attn_protein_challenge_rmkt'
	AND tags !~* 'subscription recurring order'
ORDER BY
	created_at DESC