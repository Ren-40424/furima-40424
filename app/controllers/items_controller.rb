class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: :edit

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
  end

  def edit
    return unless @item.user_id != current_user.id

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    return unless item.user_id == current_user.id

    item.destroy
    redirect_to root_path
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

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return unless @item.is_sold?

    redirect_to root_path
  end
end
