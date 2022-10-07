class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order
  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than: 0}
end
