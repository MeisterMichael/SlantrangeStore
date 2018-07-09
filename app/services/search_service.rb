
class SearchService < SwellEcom::EcomSearchService



	def subscription_search( term, filters = {}, options = {} )
		subscriptions = Subscription.all

		if term.present?
			query = "%#{term.gsub('%','\\\\%')}%"

			addresses = options[:addresses] || self.address_search( term )
			users = options[:customers] || self.customer_search( term, {}, addresses: addresses )

			subscriptions = subscriptions.where( "serial_number ILIKE :q OR code ILIKE :q OR billing_address_id IN (:address_ids) OR shipping_address_id IN (:address_ids) OR user_id IN (:user_ids)", q: query, address_ids: addresses.select(:id), user_ids: users.select(:id) )
		end

		return self.apply_options_and_filters( subscriptions, filters, options )
	end

	def user_search( term, filters = {}, options = {} )
		users = User.all

		if term.present?
			query = "%#{term.gsub('%','\\\\%')}%"

			addresses = options[:addresses] || self.address_search( term )
			users = SwellMedia.registered_user_class.constantize.where( "name ILIKE :q OR (first_name || ' ' || last_name) ILIKE :q OR email ILIKE :q OR phone ILIKE :q OR users.id IN ( :user_ids )", q: query, user_ids: addresses.select(:user_id) )
		end

		return self.apply_options_and_filters( users, filters, options )
	end

end
