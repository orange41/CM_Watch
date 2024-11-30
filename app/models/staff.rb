class Staff < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]

  validates :employee_number, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true # パスワードが空の場合はバリデーションをスキップ
end
