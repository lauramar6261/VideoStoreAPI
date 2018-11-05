class Rental < ApplicationRecord
  validates_presence_of :checkout_date
  validates_presence_of :due_date

  belongs_to :customer
  belongs_to :movie


  def initialize(attributes={})
    super
    self.active? = true
  end

end
