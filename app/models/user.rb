class User < ApplicationRecord
  has_many :items
  has_many :orders
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birth_date, presence: true
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'is invalid. Include both letters and numbers' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' }
  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー－]+\z/, message: ' is invalid. Input full-width katakana characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー－]+\z/, message: ' is invalid. Input full-width katakana characters' }
end
