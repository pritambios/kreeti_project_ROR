class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  has_many :allocation_histories

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :model_number, presence: true, length: { minimum: 2, maximum: 25 }
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :total_value, presence: true

  def save_allocation_history(user)
    allocation_history = allocation_histories.build
    allocation_history.user_id = user.id
    allocation_history.status = "reallocated"
    allocation_history.save
  end

  def save_deallocation_history(user)
    allocation_history = allocation_histories.build
    allocation_history.user_id = user.id
    allocation_history.status = "deallocated"
    allocation_history.save
  end
end
