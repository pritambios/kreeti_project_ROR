class Brand < ActiveRecord::Base
  has_many :items
  validates :name, presence: true, length: { minimum: 3, maximum: 25}
  validates_uniqueness_of :name
end
