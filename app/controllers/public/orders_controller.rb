class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def comfirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.shipping_name = current_customer.last_name + current_customer.first_name
      @order.shipping_address = current_customer.address
      @order.post_code = current_customer.postal_code
    elsif params[:order][:select_address] == "1"
    end

     @cart_items = current_customer.cart_items
     @cart_item = CartItem.new
     @total = @cart_items.inject(0) {|sum,item| sum + item.subtotal }

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if @order.save
      current_customer.cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = cart_item.customer_id
        order_detail.quantity = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.save
    end
      #cart_itemをすべて削除する記述
      current_customer.cart_items.destroy_all

      redirect_to  orders_complete_path
    else
      render :new
    end
  end


  def index
    @orders = current_customer.orders

  end

  def show
   # @order = current_customer.orders.find(params[:id])
  end


private
  def order_params
    params.require(:order).permit(:customer_id, :post_code, :shipping_address, :shipping_name, :payment_method)
  end

end
