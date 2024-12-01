class Incident < ApplicationRecord
   belongs_to :staff
   validates :title, presence: true
   validates :description, presence: true
   validates :occurred_at, presence: true
 
   # attr_accessor :occurred_at が不要な場合もあり得るのでコメントアウト
 end
 