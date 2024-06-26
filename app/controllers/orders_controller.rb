class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!, only: :index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_destination = OrderDestination.new
    return unless @item.user.id == current_user.id || @item.is_sold?

    redirect_to root_path
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      item_id: @item.id, user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
