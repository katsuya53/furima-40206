class OrderShipp
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id, :item_id, :city, :addresses
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone_number, format: { with: /\A\d+\z/, message: 'is invalid. Input only numbers.' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: lambda { |_object, data|
                                                                         if data[:value].to_s.size < 10
                                                                           'is too short'
                                                                         end
                                                                       } }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :building, allow_nil: true, length: { maximum: 255 }
  attr_accessor :prefecture

  def save
    order = Order.create(user_id:, item_id:)
    Shipp.create(postal_code:, prefecture_id:, city:, addresses:, building:,
                 phone_number:, order_id: order.id)
  end
end
