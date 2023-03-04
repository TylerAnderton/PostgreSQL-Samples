SELECT
	DATE(created_at_pst) AS date_pst,
	SUM(total) AS revenue,
	COUNT (CASE
		WHEN (subtotal = 4.95 OR subtotal = 8.95 OR subtotal = 20.91 OR subtotal = 11.94 OR subtotal = 26.93) THEN 1
		ELSE NULL END
	) AS order_count
FROM
	"public".clickfunnel_orders_all_time_view
WHERE
	DATE(created_at_pst )::date = MAKE_DATE (2023, 02, 13) 
-- 	AND DATE(created_at_pst )::date <= MAKE_DATE (2023, 01, 19) 
	AND 
	LOWER(utm_term) IN (
      'pkit-4-protein50-popup', 'pkit-4-protein50-popup-followup', 'pkit-4-protein50-popup-vc', 'pkit-4-protein50-popup-vc-followup'
    )
GROUP BY
	date_pst
ORDER BY
	date_pst DESC