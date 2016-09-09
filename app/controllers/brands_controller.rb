class BrandsController < ApplicationController

  def index
    @brands = Brand.paginate(page: params[:page], per_page: 5)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = "Brand was created successfully"
      redirect_to brands_path
    else
      render 'new'
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      flash[:success] = "Brand name was successfully updated"
      redirect_to brand_path(@brand)
    else
      render 'edit'
    end
  end

  def show
    @brand = Brand.find(params[:id])
    @brand_items = @brand.items.paginate(page: params[:page], per_page: 5)
  end
  private
  def brand_params
    params.require(:brand).permit(:name)
  end
end
