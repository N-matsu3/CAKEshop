class Item < ApplicationRecord
  #enum genre_id:{ cake: 1, baked_sweets: 2, unbaked_sweets: 3, etc: 4}

  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  def with_tax_price
    (price * 1.1).floor
  end



end
