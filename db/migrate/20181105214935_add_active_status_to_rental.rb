class AddActiveStatusToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :active?, :boolean
  end
end
