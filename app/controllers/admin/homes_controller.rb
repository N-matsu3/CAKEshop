class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.page(params[:page])

    #@order.id = @order_detail(:order_id)

      #@total_quantity += order_detail.quantity
    #@order.total_quantity = @total_quantity

  end
end
