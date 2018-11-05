class RemoveQuestionMarkFromColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :active?
    add_column :rentals, :active, :boolean
  end
end
