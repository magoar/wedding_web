class AddTableNumberToGuests < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :table_number, :integer
  end
end
