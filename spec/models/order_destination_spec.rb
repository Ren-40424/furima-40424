require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, item_id: item.id, user_id: item.user_id)
  end
  
  describe '商品購入' do
    context '購入できるとき' do
      it 'すべての情報が適切なら購入できる' do
        expect(@order_destination).to be_valid
      end

      it '建物名がなくても購入できる' do
        @order_destination.building_name = ''
        expect(@order_destination).to be_valid
      end
    end

    context '購入できないとき' do
      it 'ユーザーが紐づいていないと購入できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐づいていないと購入できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が必須であること' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の文字列のみ保存可能なこと' do
        @order_destination.postal_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '郵便番号は半角の文字列のみ保存可能なこと' do
        @order_destination.postal_code = '１２３‐４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it '都道府県が必須であること' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が必須であること' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      
      it '電話番号が必須であること' do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は10桁以上11桁以内の数値のみ保存可能なこと' do
        @order_destination.phone_number = '090-1234-5678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号は半角数値が必須であること' do
        @order_destination.phone_number = '１１１１１１１１１１１'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid")
      end

      it 'トークンが必須であること' do
        @order_destination.token = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
