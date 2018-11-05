class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :customer, foreign_key: true
      t.references :movie, foreign_key: true
      t.date :checkout_date
      t.date :due_date

      t.timestamps
    end
  end
end
