class GuestsController < ApplicationController

  def index
    @guests = Guest.all
    @total = @guests.sum { |g| 1 + (g.guests_count || 0) }
  end
  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      redirect_to root_path, notice: "Confirmation successfully sended. Thank you!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :guests_count, :message)
  end
end
