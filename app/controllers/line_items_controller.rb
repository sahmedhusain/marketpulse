class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy, :decrement]
  before_action :set_line_item, only: [:destroy, :decrement]

  # POST /line_items
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_back fallback_location: root_path, notice: "Added to your cart" }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { redirect_back fallback_location: root_path, alert: "Could not add item to cart." }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: "Removed from your cart" }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /line_items/1/decrement
  def decrement
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.save
    else
      @line_item.destroy
    end

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: "Removed from your cart" }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id)
  end
end
