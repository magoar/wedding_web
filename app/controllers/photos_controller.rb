class PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      head :ok
    else
      render json: { error: @photo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:album_id, :url, :public_id)
  end
end
