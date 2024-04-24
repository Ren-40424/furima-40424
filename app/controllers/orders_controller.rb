class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!, only: :index

  def index
    @order_destination = OrderDestination.new
    return unless @item.user.id == current_user.id || @item.is_sold?

    redirect_to root_path
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(item_id: @item.id, user_id: current_user.id)
  end
end
