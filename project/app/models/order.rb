class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :address
  validates :num, :numericality => {greater_than: 0}
  validates :state, presence: true
end
