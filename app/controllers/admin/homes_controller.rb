class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    
    #@order.id = @order_detail(:order_id)

      #@total_quantity += order_detail.quantity
    #@order.total_quantity = @total_quantity

  end
end
