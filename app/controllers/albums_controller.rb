require 'zip'
require 'open-uri'

class AlbumsController < ApplicationController
  def index
    @albums = Album.all.order(created_at: :desc)
  end

  def new
    @album = Album.new# Initialize at least one photo for the form
  end

  def show
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      # Redirigimos a show donde estará el botón de subir archivos
      redirect_to album_path(@album) #, notice: "Album created successfully."
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

  # Recibe la URL de Cloudinary y la asocia al álbum
  def upload_direct
    album = Album.find(params[:album_id])

    # params[:file_url] contiene la URL directa del archivo en Cloudinary
    file_url = params[:file_url]

    # Creamos un attachment para ActiveStorage
    album.photos.attach(
      io: URI.open(file_url),
      filename: File.basename(URI.parse(file_url).path)
    )

    head :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  private
  def album_params
    params.require(:album).permit(:title, :description, photos: [])
  end
end
