class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @q = current_user.products.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to new_product_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { redirect_to new_product_path, alert: "Product name has already been taken" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to edit_product_path(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { redirect_to edit_product_path(@product), alert: "Product name has already been taken" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to edit_all_products_path, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit_all_products
    @q = current_user.products.ransack(params[:q])
    @products = @q.result(distinct: true)

    # @products = current_user.products.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_user.products.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :price, :image)
    end
end
