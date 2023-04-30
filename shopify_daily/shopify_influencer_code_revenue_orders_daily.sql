SELECT
	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date AS date_pst,
	code,
	ROUND(SUM(total_price)::numeric, 2) AS total,
	COUNT(*) AS order_count
FROM
	(
		SELECT 
			*,
			arr.item_object ->> 'code' AS code
		FROM 
			shopify_influencer_code_orders
			LEFT JOIN LATERAL jsonb_array_elements(discount_codes) with ordinality arr(item_object, position) ON TRUE
	) AS influencer_orders_w_code

-- WHERE
-- 	DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date >= MAKE_DATE(2023, 01, 01) 
-- 	AND DATE_TRUNC('day', created_at, 'America/Los_Angeles')::date <= MAKE_DATE(2023, 04, 10)
GROUP BY
	date_pst,
	code
ORDER BY
	date_pst DESC,
	code ASC