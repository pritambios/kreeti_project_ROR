class ItemsController < ApplicationController
  before_action :get_item, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page], per_page: 5)
    @users = User.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @allocation = @item.allocation_histories.new
    @item.user = current_user
    @allocation.user = current_user
    @allocation.status = "allocated"

    respond_to do |format|
      if @item.save and @allocation.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def history
    @item = Item.find(params[:format])
    @histories = @item.allocation_histories.paginate(page: params[:page], per_page: 5).order("updated_at DESC")
  end

  def reallocate
    @item = Item.find(params[:id])

    if @item.update(reallocate_user_params)
      @allocation = @item.save_allocation_history(@item.user)
      flash[:success] = "item is successfully reallocated"
      redirect_to history_path(@item)
    end
  end

  def deallocate
    @item = Item.find(params[:format])
    @last_allocation = @item.allocation_histories.allotement.first

    if @last_allocation
      @item.user_id = current_user.id
      @item.save
      @allocation = @item.save_deallocation_history(@last_allocation.user)
      flash[:success] = "Item was successfully deallocated, Now it is reallocated to Admin"
      redirect_to history_path(@item)
    end
  end

  private

  def get_item
    @item = Item.find(params[:id])
  end

  def reallocate_user_params
    params.require(:item).permit(:user_id)
  end

  def item_params
    params.require(:item).permit(:name, :description, :model_number, :quantity, :unit_price, :total_value, :image, :category_id, :brand_id)
  end

  def require_same_user
    return if current_user == @item.user || current_user.admin?

    flash[:danger] = 'You can only edit or delete your own articles.'
    redirect_to articles_path
  end
end
