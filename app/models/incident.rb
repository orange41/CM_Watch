class Incident < ApplicationRecord
  belongs_to :staff
  has_many :comments, dependent: :destroy
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_at, presence: true
  validates :approved, inclusion: { in: [true, false] }
  # attr_accessor :occurred_at が不要な場合もあり得るのでコメントアウト
end
