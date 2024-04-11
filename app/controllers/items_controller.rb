class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: :index
  
  def index
  end

  def new
    @item = Item.new
  end

  private

  def move_to_sign_in
    unless user_signed_in?
      redirect_to user_session_path
    end
  end
end
