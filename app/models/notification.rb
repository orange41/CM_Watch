class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
end
