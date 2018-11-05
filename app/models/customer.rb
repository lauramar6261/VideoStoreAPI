class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals
  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, presence: true

  def movies_checked_out_count
    return self.rentals.where(active: true).count
  end
end
