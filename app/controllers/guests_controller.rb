class GuestsController < ApplicationController

  def index
    @guests = Guest.order(created_at: :desc)
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

  def update
    @guest = Guest.find(params[:id])
    if @guest.update(guest_params)
      respond_to do |format|
        format.html { redirect_to guests_path, notice: "Guest updated successfully." }
        format.json { render json: { guests_count: @guest.guests_count }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to guests_path, alert: "Could not update guest." }
        format.json { render json: { errors: @guest.errors.full_messages }, status: :unprocessable_entity }
      end
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
    gp = params.require(:guest).permit(:name, :message, :guests_count, :table_number)
    if gp.key?(:table_number)
      val = gp[:table_number]
      if val.blank?
        gp[:table_number] = nil
      elsif val.to_s.strip.downcase == "vip"
        gp[:table_number] = 22   # <-- map VIP to 22
      else
        gp[:table_number] = val.to_i
      end
    end
    gp
  end
end
