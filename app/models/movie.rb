class Movie < ApplicationRecord
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true
  validates :available_inventory, presence: true
  validates_numericality_of :inventory, greater_than_or_equal_to: 0
  validates_numericality_of :available_inventory, greater_than_or_equal_to: 0

  has_many :rentals
  has_many :customers, through: :rentals
end
