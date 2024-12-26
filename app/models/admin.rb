class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]

  validates :employee_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: true
  validate :name_presence, on: :update
  
  has_many :notifications, as: :notifiable

  private

  def name_presence
    if name.blank?
      errors.add(:name, "can't be blank")
    end
  end
end
