SELECT
	COALESCE(zapier.charge_id, history. charge_id) AS charge_id,
	COALESCE(zapier.first_name, history. first_name) AS first_name,
	COALESCE(zapier.last_name, history. last_name) AS last_name,
	COALESCE(zapier.email, history. email) AS email,
	COALESCE(zapier.phone, history. phone) AS phone,
	COALESCE(zapier.shipping_address, history. shipping_address) AS shipping_address,
	COALESCE(zapier.shipping_city, history. shipping_city) AS shipping_city,
	COALESCE(zapier.shipping_state, history. shipping_state) AS shipping_state,
	COALESCE(zapier.shipping_country, history. shipping_country) AS shipping_country,
	COALESCE(zapier.shipping_zip_code, history. shipping_zip_code) AS shipping_zip_code,
	COALESCE(zapier.product_ids, history.product_ids) AS product_ids,
	COALESCE(zapier.product_names, history. product_names) AS product_names,
	COALESCE(zapier.created_at_utc, history.created_at_utc) AS created_at_utc,
	COALESCE(zapier.funnel_id, history.funnel_id) AS funnel_id,
	COALESCE(zapier.funnel_step_id, history. funnel_step_id) AS funnel_step_id,
	COALESCE(zapier.original_amount_cents, history.original_amount_cents) AS original_amount_cents,
	COALESCE(zapier.original_amount_currency, history.original_amount_currency) AS original_amount_currency,
	COALESCE(zapier.status, history.status) AS status,
	COALESCE(zapier.subscription_id, history.subscription_id) AS subscription_id,
	COALESCE(zapier.utm_source, history.utm_source) AS utm_source,
	COALESCE(zapier.utm_medium, history.utm_medium) AS utm_medium,
	COALESCE(zapier.utm_campaign, history.utm_campaign) AS utm_campaign,
	COALESCE(zapier.utm_term, history.utm_term) AS utm_term,
	COALESCE(zapier.utm_content, history.utm_content) AS utm_content,
	COALESCE(zapier.stripe_customer_token, history.stripe_customer_token) AS stripe_customer_token
FROM
	"public".clickfunnel_orders_zapier_raw AS zapier
	FULL OUTER JOIN "public".clickfunnel_orders_historical_upload_transform_view AS history USING (charge_id)
ORDER BY
	created_at_utc DESC