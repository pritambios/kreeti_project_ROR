class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # GET /items
  # GET /items.json
  def index
    @items = Item.paginate(page: params[:page], per_page: 5)
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
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

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
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

  # DELETE /items/1
  # DELETE /items/1.json
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
  def reallocateuser
    @user = User.all
  end
  def reallocate
    @item = Item.find(params[:id])
    if @item.update(params.require(:item).permit(:user_id))
      @allocation = @item.allocation_histories.new
      @allocation.item_id = params[:id]
      @allocation.user_id = @item.user_id
      @allocation.status = "reallocated"
      @allocation.save
      flash[:warning] = "item is successfully reallocated"
      redirect_to history_path(@item)
    end
  end
  def deallocate
    @item = Item.find(params[:format])
    @last_allocation = @item.allocation_histories.where(status: ["allocated","reallocated"]).order("updated_at DESC").first
    @second_last_allocation = @item.allocation_histories.where(status: ["allocated","reallocated"]).order("updated_at DESC").second
    if !@second_last_allocation.nil?
      @last_allocation.status = "deallocated"
      @item.user_id = @second_last_allocation.user_id
      @allocation = @item.allocation_histories.new
      @allocation.item_id = params[:format]
      @allocation.user_id = @last_allocation.user_id
      @allocation.status = "deallocated"
      @last_allocation.save
      @item.save
      @allocation.save
      flash[:warning] = "item is successfully deallocated"
      redirect_to history_path(@item)
    else
      flash[:danger] = "Sorry!!, no other allocation history found for this item. If you want to allocate to other user please try rellocation."
      redirect_to history_path(@item)
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :model_number, :quantity, :unit_price, :total_value, :image, :category_id, :brand_id)
    end
    def require_same_user
      return if current_user == @item.user || current_user.admin?

      flash[:danger] = 'You can only edit or delete your own articles.'
      redirect_to articles_path
    end

end
