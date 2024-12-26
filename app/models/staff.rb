class Staff < ApplicationRecord
  has_many :incidents
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]

  validates :employee_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: true # パスワードが空の場合はバリデーションをスキップ
  validates :name, presence: true, allow_blank: true # 名前は空でもよい
  
  has_many :notifications, as: :notifiable
end
