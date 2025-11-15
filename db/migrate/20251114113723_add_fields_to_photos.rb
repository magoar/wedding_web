class AddFieldsToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :url, :string
    add_column :photos, :public_id, :string
  end
end
