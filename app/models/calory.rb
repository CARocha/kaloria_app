class Calory < ApplicationRecord
  belongs_to :user
  default_scope -> { order(date: :desc) }
  paginates_per 10
  validates :user_id, presence: true
  validates :comment, presence: true
  validates :calories_ingested, presence: true, numericality: true
  validates :calories_burned, presence: true, numericality: true
end
