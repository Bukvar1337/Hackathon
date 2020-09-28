class Api::PositionsController < ApplicationController
  def index
    @positions = Position.includes([:item]).all
    render json: @positions.as_json(include: :item)
  end

  # def delete
  # @position = Position.find(params[:id])
  # @cart = Cart.find(@position.cart_id)
  # @position.destroy
  #  @positions = @cart.positions
  # @fullPrice = 0
  # @positions.each do |position|
  #    @fullPrice = @fullPrice + position.item.price * position.quantity
  # end
  #  @cart.fullPrice = @fullPrice
  # @cart.save
  #
  #   redirect_to cart_path(@cart)
  # end
end
