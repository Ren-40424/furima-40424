class OrderDestination
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :order_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
  end

  validates :postal_code, format: {with: /\d{3}-\d{4}/, message: "is invalid. Include hyphen(-)"}, allow_nil: true
  validates :phone_number, format: {with: /\d{10,11}/}, allow_nil: true

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Destination.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number)
  end
end