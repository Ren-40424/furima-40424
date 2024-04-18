class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
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
