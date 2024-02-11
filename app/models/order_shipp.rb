class OrderShipp
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id, :item_id, :city, :addresses
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, format: { with: /\A[a-z0-9]+\z/i, message: 'is invalid. Input half-width characters.' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(user_id:, item_id:)
    Shipp.create(postal_code:, prefecture_id:, city:, addresses:, building:,
                 phone_number:, order_id: order.id)
  end
end
