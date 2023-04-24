class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
     redirect_to  orders_comfirm_path
    else
      render :new
    end
  end

  def index
  end
end
