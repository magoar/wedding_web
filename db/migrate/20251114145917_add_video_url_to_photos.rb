class AddVideoUrlToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :video_url, :string
  end
end
