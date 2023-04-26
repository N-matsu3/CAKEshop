class Public::CartItemsController < ApplicationController
  def index
     @cart_items = current_customer.cart_items
     @cart_item = CartItem.new
     @total = @cart_items.inject(0) {|sum,item| sum + item.subtotal }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
     binding.pry
     increase_or_create(params[:cart_item][:item_id],params[:cart_item][:amount].to_i)
     redirect_to cart_items_path, notice: 'カートに追加しました'
  end

  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice: 'カート内情報を更新しました'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: '１つのカート内商品を削除しました'
  end

  def destroy_all
      current_customer.cart_items.destroy_all
      redirect_to cart_items_path, notice: 'カートを空にしました'
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

  def increase_or_create(item_id, amount)
    cart_item = current_customer.cart_items.find_by(item_id: item_id)
    if cart_item
      cart_item.increment!(:amount, amount)
    else
      current_customer.cart_items.build(item_id: item_id,amount: amount).save
    end
  end

  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:amount, 1)
    else
      cart_item.destroy
    end
  end

end

