class TrackedDeviceAdminController < SwellMedia::AdminController
	before_action :get_tracked_device, except: [ :bulk_create, :create, :index ]

	def bulk_create
		authorize( TrackedDevice, :admin_create? )
		@tracked_devices = []

		if params[:serial_numbers_csv].present?

			serial_numbers = params[:serial_numbers_csv].strip.split(',').collect(&:strip).select(&:present?)
			serial_numbers.each do |serial_number|
				@tracked_devices << TrackedDevice.create( tracked_device_params.merge( serial_number: serial_number ) )
			end

		end

		tracked_devices_with_errors = @tracked_devices.select{|tracked_device| tracked_device.errors.present? }

		if tracked_devices_with_errors.present?
			set_flash "#{@tracked_devices} Tracked Devices Created", :success
		else
			tracked_devices_with_errors.each do |tracked_devices|
				set_flash 'Tracked Device could not be created', :error, tracked_devices
			end
		end

		redirect_back( fallback_location: tracked_device_admin_index_path() )

	end

	def create
		@tracked_device = TrackedDevice.new( tracked_device_params )

		if @tracked_device.save
			set_flash 'Tracked Device Created'
			redirect_to edit_tracked_device_admin_path( @tracked_device )
		else
			set_flash 'Tracked Device could not be created', :error, @tracked_device
			redirect_back( fallback_location: tracked_device_admin_index_path() )
		end
	end

	def destroy
		authorize( TrackedDevice, :admin_destroy? )
		@tracked_device.destroy
		set_flash 'Tracked Device Deleted'
		redirect_back( fallback_location: tracked_device_admin_index_path() )
	end


	def edit
		authorize( @tracked_device, :admin_edit? )
	end


	def index
		authorize( TrackedDevice, :admin? )

		sort_by = params[:sort_by] || 'created_at'
		sort_dir = params[:sort_dir] || 'desc'

		filters = ( params[:filters] || {} ).select{ |attribute,value| not( value.nil? ) }
		filters[ params[:status] ] = true if params[:status].present? && params[:status] != 'all'
		@tracked_devices = SearchService.new.tracked_device_search( params[:q], filters, page: params[:page], order: { sort_by => sort_dir } )

		@tracked_devices = @tracked_devices.page( params[:page] )
	end


	def update
		authorize( @tracked_device, :admin_update? )
		@tracked_device.attributes = tracked_device_params

		if @tracked_device.save
			set_flash 'Tracked Device Updated'
			redirect_to edit_tracked_device_admin_path( id: @tracked_device.id )
		else
			set_flash 'Tracked Device could not be Updated', :error, @tracked_device
			render :edit
		end

	end


	private
		def tracked_device_params
			params.require( :tracked_device ).permit( :user_id, :device_type_id, :status, :make, :model, :version, :serial_number, :notes )
		end

		def get_tracked_device
			@tracked_device = TrackedDevice.find( params[:id] )
		end


end
