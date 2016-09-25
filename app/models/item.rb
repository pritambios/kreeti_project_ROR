class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :allocation_histories

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :model_number, presence: true, length: { minimum: 2, maximum: 25 }
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :total_value, presence: true
end
