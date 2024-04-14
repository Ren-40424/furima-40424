class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: :index

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def move_to_sign_in
    return if user_signed_in?

    redirect_to user_session_path
  end

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :price, :category_id, :condition_id, :shipping_payer_id,
                                 :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end
end
