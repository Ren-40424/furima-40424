class ShippingDate < ActiveHash::Base
  self.data = [
    { id: , name: '---' },
    { id: , name: '1~2日で発送' },
    { id: , name: '2~3日で発送' },
    { id: , name: '4~7日で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end