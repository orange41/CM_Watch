class Comment < ApplicationRecord
  belongs_to :incident
  belongs_to :staff
  validates :content, presence: true

  # デフォルト値を設定
  attribute :approved, :boolean, default: false
end
