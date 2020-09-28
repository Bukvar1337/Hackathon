class Api::LikesController < ApplicationController
  before_action :find_like, only: [:destroy]

  def index
     @like = Like.all
    render json: @like.as_json
  end

  def create
    @like = Like.new(like_params)
    unless Like.where("user_id = #{@like.user_id}").where(["likeable_type LIKE ?", "%#{@like.likeable_type}%"]).where("likeable_id = #{@like.likeable_id}").exists?
      @like.state = true
      @like.save
      @object = @like.likeable_type.constantize.find(@like.likeable_id)
      @object.increment!(:votesCount)
     end
      render json: @object.as_json
  end

  def destroy
    @object = @like.likeable_type.constantize.find(@like.likeable_id)
    @object.votesCount -= 1
    @object.save
    @like.destroy
    render json: @object.as_json
    #redirect_to api_likes_path
  end

  private def like_params
    params.require(:like).permit(:state,:user_id,:likeable_id,:likeable_type)
  end

  private def find_like
    @like = Like.find(params[:id])
  end

end