class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :title, presence: true
  validates :rate, numericality: { greater_than: 0}
  validates :comment, presence: true
  
end
