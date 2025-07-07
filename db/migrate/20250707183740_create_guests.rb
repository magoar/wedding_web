class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.integer :guests_count
      t.text :message

      t.timestamps
    end
  end
end
