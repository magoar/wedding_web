require 'zip'

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

  def download
    album = Album.find(params[:id])
    attachments = album.photos

    if attachments.attached?
      compressed_filestream = Zip::OutputStream.write_buffer do |zos|
        attachments.each do |att|
          filename = att.filename.to_s
          zos.put_next_entry(filename)
          zos.write att.download
        end
      end
      compressed_filestream.rewind
      send_data compressed_filestream.sysread, filename: "#{album.title.parameterize}_photos.zip", type: 'application/zip', disposition: 'attachment'
    else
      redirect_back fallback_location: albums_path, alert: "No photos to download."
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :description, photos: [])
  end
end
