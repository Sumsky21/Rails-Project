class Address < ApplicationRecord
  belongs_to :user
  validates :recipient, presence: true
  validates :district, presence: true
  validates :details, presence: true
  validates :postal_code, presence: true
  validates :phone_number, presence: true
end
