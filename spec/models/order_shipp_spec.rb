require 'rails_helper'

RSpec.describe OrderShipp, type: :model do
  describe '購入可能かどうかのテスト' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_shipp = FactoryBot.build(:order_shipp, user_id: user.id, item_id: item.id)
      sleep 0.1 # Mysql2::Errorを回避
    end

    context '購入可能な場合' do
      it '郵便番号、都道府県、市区町村、番地、電話番号、tokenが入力されていれば購入できる' do # ランダム値 : 郵便番号は「3桁-4桁」、都道府県は2から48、電話番号は10桁以上11桁以内の半角数値
        expect(@order_shipp).to be_valid
      end
      it '建物名は空でも購入できる' do
        @order_shipp.building = ' '
        expect(@order_shipp).to be_valid
      end
    end

    context '購入ができない場合' do
      it 'user_idが空だと購入できない' do
        @order_shipp.user_id = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと購入できない' do
        @order_shipp.item_id = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと購入できない' do
        @order_shipp.postal_code = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空だと購入できない' do
        @order_shipp.prefecture_id = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと購入できない' do
        @order_shipp.city = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと購入できない' do
        @order_shipp.addresses = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空だと購入できない' do
        @order_shipp.phone_number = ' '
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Phone number can't be blank")
      end
      it '郵便番号が「3桁-4桁」ではないと購入できない' do
        @order_shipp.postal_code = '1234567'
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '電話番号が9桁以内だと購入できない' do
        @order_shipp.phone_number = '123456789'
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include('Phone number is too short')
      end
      it '電話番号が半角数値以外だと購入できない' do
        @order_shipp.phone_number = '１２３４５６７８９０'
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include('Phone number is invalid. Input only numbers.')
      end
      it 'tokenが空では購入できない' do
        @order_shipp.token = nil
        @order_shipp.valid?
        expect(@order_shipp.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
