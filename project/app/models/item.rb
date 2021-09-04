class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :cover_img
  has_many :orders
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :cover_img, presence: true
  validate :acceptable_image

  def acceptable_image
    return unless cover_img.attached?

    # validate image's size
    unless cover_img.byte_size <= 1.megabyte
      errors.add(:cover_img, 'should not be larger than 1MB')
    end

    # validate image's format
    acceptable_types = ["image/jpg", "image/jpeg", "image/png"]
    unless acceptable_types.include?(cover_img.content_type)
      errors.add(:cover_img, "must be a JPG, JPEG or PNG")
    end
  end
end
