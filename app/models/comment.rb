class Comment < ApplicationRecord
  belongs_to :item, presence: true
  belongs_to :user, presence: true

  validates :text, presence: true
end

