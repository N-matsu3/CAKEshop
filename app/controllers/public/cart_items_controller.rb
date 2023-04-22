class Public::CartItemsController < ApplicationController
  def index
     @cart_items = current_customer.cart_items
     @cart_item = CartItem.new
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
     increase_or_create(params[:cart_item][:item_id])
     redirect_to cart_items_path, notice: 'カートに追加しました'
  end

  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice: 'Successfully updated your cart'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy(cart_item_params)
    redirect_to cart_items_path, notice: 'Successfully deleted one cart item'
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item.increment!(:quantity, 1)
    else
      current_customer.cart_items.build(item_id:).save
    end
  end

  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end

end

