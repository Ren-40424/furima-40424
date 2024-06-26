class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_payer
  belongs_to :prefecture
  belongs_to :shipping_date
  has_one_attached :image
  has_one :order

  validates :image,             presence: true
  validates :name,              presence: true
  validates :explanation,       presence: true
  validates :price,             presence: true
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, allow_nil: true
  validates :category_id,       numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_payer_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,     numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_date_id,  numericality: { other_than: 1, message: "can't be blank" }

  def is_sold?
    Order.exists?(item_id: id)
  end
end
