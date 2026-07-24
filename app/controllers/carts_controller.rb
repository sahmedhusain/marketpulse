class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts/1
  def show
  end

  # DELETE /carts/1 (Empty Cart action)
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Your cart is currently empty." }
      format.json { head :no_content }
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, alert: "Invalid cart"
  end
end
