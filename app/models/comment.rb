class Comment < ApplicationRecord
  belongs_to :incident
  belongs_to :staff

  validates :content, presence: true
end
