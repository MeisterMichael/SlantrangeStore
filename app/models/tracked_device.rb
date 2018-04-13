class TrackedDevice < ApplicationRecord

	belongs_to :device_type
	belongs_to :user, optional: true

	enum status: { 'decommissioned' => -1, 'available' => 0, 'owned' => 1, 'returning' => 2, 'returned' => 3, 'processing' => 4 }


end
