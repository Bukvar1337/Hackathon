class Api::ItemsController < ApplicationController
  before_action :find_item, only: [:show, :update, :destroy, :add_item_to_cart, :remove_item_from_cart]
  after_action :refresh, only: [:add_item_to_cart, :remove_item_from_cart]

  def index
    @item = Item.where(["name LIKE ?", "%#{params[:search]}%"])
    render json: @item.as_json
  end

  def show
    render json: @item.as_json(include: :comments)
  end

  def update
    if(@item.update(item_params))
      render json: @item.as_json
    else
      render json: { success: false, errors: @item.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    if @carts = Cart.where("item_id =#{@item.id}").exists?
    @item.destroy
    @carts.each do |cart|
    @positions = cart.positions
    @fullPrice = 0
    @positions.each do |position|
      @fullPrice = @fullPrice + position.item.price * position.quantity
      cart.update(fullPrice: @fullPrice)
    end
    end
    else
      @item.destroy
      end
    redirect_to items_path
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item.as_json
    else
      render json: { success: false, errors: @item.errors.as_json }, status: :unprocessable_entity
    end
  end

  def add_item_to_cart
    @user = User.find(params[:user_id])
    @cart = @user.cart
    @quantity_put = params[:quantity]
    unless @cart.positions.where("item_id = #{@item.id}").exists?
      @position = Position.create(item_id: @item.id, cart_id: @cart.id, quantity: @quantity_put)
    else
      @position = @cart.positions.where("item_id =#{@item.id}").first
      @quantity = @position.quantity + @quantity_put.to_i
      @position.update(quantity: @quantity)
    end
  end

  def remove_item_from_cart
    @user = User.find(params[:user_id])
    @cart = @user.cart
    @position = @cart.positions.where("item_id = #{@item.id}").first
    @position.destroy
  end

  private def item_params
    params.require(:item).permit(:name,:weight,:price,:description,:user_id)
  end

  private def position_params
    params.require(:position).permit(:quantity)
  end

  private def find_item
    @item = Item.find(params[:id])
  end

  private def refresh
    @positions = @cart.positions
    @fullPrice = 0
    @positions.each do |position|
      @fullPrice = @fullPrice + position.item.price * position.quantity
      @cart.update(fullPrice: @fullPrice)
    end
    render json: @cart.as_json(include: :positions)
  end

end
