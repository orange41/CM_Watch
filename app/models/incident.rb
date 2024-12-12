class Incident < ApplicationRecord
  belongs_to :staff
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_at, presence: true

  # attr_accessor :occurred_at が不要な場合もあり得るのでコメントアウト
end
