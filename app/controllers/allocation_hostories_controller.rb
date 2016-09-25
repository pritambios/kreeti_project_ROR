class AllocationHistoriesController < ApplicationController
  def history
    @allocations = AllocationHistory.paginate(page: params[:page], per_page: 5)
  end
  def show
  end
  def reallocation
  end
  def deallocation
  end
end
