class AllocationHistory < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  scope :allotement, -> { where(status: ["allocated","reallocated"]).order("updated_at DESC") }
end
