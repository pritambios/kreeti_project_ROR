class Brand < ActiveRecord::Base
  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: true }, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end
