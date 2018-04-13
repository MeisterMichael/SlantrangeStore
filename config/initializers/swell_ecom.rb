
SwellEcom.configure do |config|

	config.origin_address = {}

	config.warehouse_address = {
		street: '4901 Morena Blvd',
		city: 'San Diego',
		state: 'CA',
		zip: '92117',
		country: 'US',
		phone: '1.858.412.4323'
	}

	config.nexus_addresses = []

	config.order_email_from = "no-reply@#{ENV['APP_DOMAIN']}"

	# config.transaction_service_class = "::ApplicationTransactionService"
	# config.transaction_service_config = {}

	config.shipping_service_class = "SwellEcom::ShippingServices::UPSShippingService"
	config.shipping_service_config = {
		ship_from: {
			company_name: 'SlantRange, Inc.',
		    phone_number: config.warehouse_address[:phone],
		    address_line_1: config.warehouse_address[:street],
		    address_line_2: config.warehouse_address[:stree2],
		    city: config.warehouse_address[:city],
		    state: config.warehouse_address[:state],
		    postal_code: config.warehouse_address[:zip],
		    country: config.warehouse_address[:country],
      		# email_address: 'nobody@example.com',
		},
		shipper: {
			company_name: 'SlantRange, Inc.',
		    phone_number: config.warehouse_address[:phone],
		    address_line_1: config.warehouse_address[:street],
		    address_line_2: config.warehouse_address[:stree2],
		    city: config.warehouse_address[:city],
		    state: config.warehouse_address[:state],
		    postal_code: config.warehouse_address[:zip],
		    country: config.warehouse_address[:country],
			shipper_number: ENV['UPS_ACCOUNT_NUMBER'],
      		# email_address: 'nobody@example.com',
		},
		api_key: ENV["UPS_LICENSE_NUMBER"],
		username: ENV["UPS_USER_ID"],
		password: ENV["UPS_PASSWORD"],
	}


	# config.subscription_service_class = "::ApplicationSubscriptionService"
	# config.subscription_service_config = {}


	config.tax_service_class = "::ApplicationTaxService"
	# config.tax_service_config = {}

	# config.discount_service_class = "::ApplicationDiscountService"
	# config.discount_service_config = {}

	# config.order_code_prefix = 'swell-o'
	# config.subscription_code_prefix = 'swell-s'

	# config.automated_fulfillment = true

	# config.create_user_on_checkout = true

	# config.store_path = 'shop'

end
