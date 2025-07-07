class GuestsController < ApplicationController
  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      redirect_to root_path, notice: "Confirmation successfully sended."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :guests_count, :message)
  end
end
