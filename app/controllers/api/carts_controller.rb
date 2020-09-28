class Api::CartsController < ApplicationController
  before_action :find_cart, only: [:show, :update]

  def show
    render json: @cart.as_json(include: :positions)
  end

  def update
    @positions = @cart.positions
    @fullPrice = 0
    @positions.each do |position|
      @fullPrice = @fullPrice + position.item.price * position.quantity
    end
    @cart.update(fullPrice: @fullPrice)
    render json: @cart.as_json(include: :positions)
  end

  private def find_cart
     @cart = Cart.find(params[:id])
   end
end
