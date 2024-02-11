class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :purchase_limit, only: [:index, :create]

  def index
    @order_shipp = OrderShipp.new
  end

  def create
    @order_shipp = OrderShipp.new(order_params)
    if @order_shipp.valid?
      @order_shipp.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipp).permit(:postal_code, :prefecture_id, :city, :addresses, :building,
                                        :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def purchase_limit
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.nil? || @item.order.present? || current_user == @item.user
  end
end
