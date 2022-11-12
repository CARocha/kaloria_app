class Calory < ApplicationRecord
  belongs_to :user
  default_scope -> { order(date: :desc) }
  scope :created_between, lambda {|start_date, end_date| where("date >= ? AND date <= ?", start_date, end_date )}
  paginates_per 10
  validates :user_id, presence: true
  validates :comment, presence: true
  validates :calories_ingested, presence: true, numericality: true
  validates :calories_burned, presence: true, numericality: true
end
