class OrderDestination
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :order_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)", allow_blank: true }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, allow_blank: true }
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Destination.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number)
  end
end