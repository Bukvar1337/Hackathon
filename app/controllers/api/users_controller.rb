class Api::UsersController < ApplicationController
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @user = User.includes([:comments,:cart])
    render json: @user.as_json(include: :likes) #[:comments, :cart])
  end

  def show
    render json: @user.as_json(include: :comments)
  end

  def update
    if(@user.update(user_params))
      render json: @user.as_json
    else
      render json: { success: false, errors: @user.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def create
    @user = User.create(user_params)
    @cart = Cart.create(user_id: @user.id)

    if @user.save && @cart.save
      render json: @user.as_json(include: :cart)
    else
      render json: { success: false, errors: @user.errors.as_json }, status: :unprocessable_entity
    end
  end

  private def user_params
    params.require(:user).permit(:email, :password,:password_confirmation, :firstName, :secondName, :sex, :age, :login,:gitLink,cart_attributes:[:id, :name, :user_id])
  end

  private def find_user
    @user = User.find(params[:id])
  end
end
