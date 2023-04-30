SELECT
	"First Name" AS first_name,
	"Last Name" AS last_name,
	"Email" AS email,
	"Shipping Address 1" AS shipping_address,
	"Shipping City" AS shipping_city,
	"Shipping State" AS shipping_state,
	"Shipping Country" AS shipping_country,
	"Shipping Zip" AS shipping_zip_code,
	"Phone" AS phone,
	"Product Names" AS product_names,
	"Funnel Step" AS funnel_step_id,
	"Charge" AS charge_id,
	"Created At" AS created_at_utc,
	"Funnel" AS funnel_id,
	"Original Amount Cents" AS original_amount_cents,
	"Original Amount Currency" AS original_amount_currency,
	"Status" AS status,
	"Subscription" AS subscription_id,
	SUBSTRING(
		"Additional Info", 
		POSITION('utm_source=>' IN "Additional Info")+13,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('utm_source=>' IN "Additional Info") + 13)) - 1 
	) AS utm_source,
	SUBSTRING(
		"Additional Info", 
		POSITION('utm_medium=>' IN "Additional Info")+13,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('utm_medium=>' IN "Additional Info") + 13)) - 1 
	) AS utm_medium,
	SUBSTRING(
		"Additional Info", 
		POSITION('utm_campaign=>' IN "Additional Info")+15,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('utm_campaign=>' IN "Additional Info") + 15)) - 1 
	) AS utm_campaign,
	SUBSTRING(
		"Additional Info", 
		POSITION('utm_term=>' IN "Additional Info")+11,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('utm_term=>' IN "Additional Info") + 11)) - 1 
	) AS utm_term,
	SUBSTRING(
		"Additional Info", 
		POSITION('utm_content=>' IN "Additional Info")+14,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('utm_content=>' IN "Additional Info") + 14)) - 1 
	) AS utm_content,
	REPLACE(
		SUBSTRING(
			"Additional Info", 
			POSITION('product_ids"=>' IN "Additional Info")+15,
			GREATEST (POSITION(']' IN SUBSTRING("Additional Info", POSITION('product_ids"=>' IN "Additional Info") + 15)) - 1, 0)
		),
		'"', 
		''
	) AS product_ids,
	SUBSTRING(
		"Additional Info", 
		POSITION('stripe_customer_token"=>' IN "Additional Info")+25,
		POSITION('"' IN SUBSTRING("Additional Info", POSITION('stripe_customer_token"=>' IN "Additional Info") + 25)) - 1 
	) AS stripe_customer_token
FROM
	"public".clickfunnel_orders_historical_upload_raw