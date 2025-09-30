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
      redirect_to root_path, notice: "Confirmation sent successfully. Thank you!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign_table
    @guest = Guest.find(params[:id])
    if @guest.update(table_number: params[:table_number])
      redirect_to guests_path, notice: "Table assigned successfully."
    else
      redirect_to guests_path, alert: "Could not assign table."
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :guests_count, :message, :table_number)
  end
end
