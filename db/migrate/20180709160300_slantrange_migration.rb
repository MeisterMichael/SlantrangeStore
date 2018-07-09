class SlantrangeMigration < ActiveRecord::Migration[5.1]
	def change

		add_column :subscriptions, :serial_number, :text, default: nil
		add_column :subscriptions, :primary_application, :text, default: nil
		add_column :subscriptions, :secondary_application, :text, default: nil
		add_index :subscriptions, [:serial_number]

		add_column :users, :company_name, :string, default: nil

	end
end
