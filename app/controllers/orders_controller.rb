class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

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
end
