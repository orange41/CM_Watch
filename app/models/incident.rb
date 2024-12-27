class Incident < ApplicationRecord
  belongs_to :staff
  belongs_to :category, optional: true  # カテゴリをオプショナルに設定
  has_many :comments, dependent: :destroy
  has_many :updates, class_name: 'Incident', foreign_key: 'original_incident_id', dependent: :destroy
  belongs_to :original_incident, class_name: 'Incident', optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_at, presence: true
  validates :approved, inclusion: { in: [true, false] }

  validates :description, presence: true, unless: :is_update_with_blank_description?

  accepts_nested_attributes_for :updates, allow_destroy: true, reject_if: :all_blank

  private

  def is_update_with_blank_description?
    original_incident_id.present? && description.blank?
  end
end
