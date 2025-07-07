class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def new
    @album = Album.new# Initialize at least one photo for the form
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to gallery_path, notice: "Album created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :description, photos: [])
  end
end
