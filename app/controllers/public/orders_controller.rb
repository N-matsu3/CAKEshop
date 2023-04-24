class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def comfirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.shipping_name = current_customer.last_name + current_customer.first_name
      @order.shipping_address = current_customer.customer_address
      @order.post_code = current_customer.postal_code
    elsif params[:order][:select_address] == "1"
    end
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
