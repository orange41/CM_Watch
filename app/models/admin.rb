class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]

  validates :employee_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
