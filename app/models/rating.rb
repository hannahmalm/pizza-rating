class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :title, presence: true
  validates :rate, presence: true
  validates :comment, presence: true
  
end
