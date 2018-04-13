
class SearchService < SwellEcom::EcomSearchService


	def tracked_device_search( term, filters = {}, options = {} )
		tracked_devices = TrackedDevice.all

		if term.present?
			query = "%#{term.gsub('%','\\\\%')}%"

			users = options[:users] || self.user_search( term, {} )

			tracked_devices = tracked_devices.where( "serial_number ILIKE :q OR user_id IN (:user_ids)", q: query, user_ids: users.select(:id) )
		end

		return self.apply_options_and_filters( tracked_devices, filters, options )
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
