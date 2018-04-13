class SlantrangeMigration < ActiveRecord::Migration[5.1]
	def change


		create_table :device_types do |t|
			t.string	:title
			t.text		:description
			t.timestamps
		end

		create_table :tracked_devices do |t|
			t.references	:user, default: nil
			t.references	:device_type
			t.integer		:status, default: 0
			t.string		:make
			t.string		:model
			t.string		:version
			t.string		:serial_number
			t.text			:notes
			t.timestamps
		end


		create_table :tracked_device_owners do |t|
			t.references	:user
			t.references	:subscription
			t.references	:tracked_device
			t.datetime		:start_at
			t.datetime		:end_at, default: nil

			t.datetime		:shipped_at, default: nil
			t.datetime		:activated_at, default: nil
			t.datetime		:returned_at, default: nil
			
			t.text			:notes

			t.timestamps
		end

	end
end
