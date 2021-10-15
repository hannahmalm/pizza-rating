class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :title, presence: true
  validates :rate, presence: true, 
  validates :rate, presence: true, :numericality => { greater_than_or_equal_to: 0, less_than: 11 }
  validates :comment, presence: true
  
end
