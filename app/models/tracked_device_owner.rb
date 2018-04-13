class TrackedDeviceOwner < ApplicationRecord

	belongs_to :tracked_device
	belongs_to :user
	belongs_to :subscription, optional: true

end
