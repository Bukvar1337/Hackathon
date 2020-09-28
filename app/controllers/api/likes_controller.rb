class Api::LikesController < ApplicationController
  before_action :find_like, only: [:destroy]
  after_action  :like_count, only: [:create]

  def index
    @likes = Like.all
    render json: @likes.as_json
  end

  def create
    @like = Like.new(like_params)
    unless Like.where("user_id = #{@like.user_id}").where(["likeable_type LIKE ?", "%#{@like.likeable_type}%"]).where("likeable_id = #{@like.likeable_id}").exists?
      @like.state = true
     @like.save
     end
      render json: @like.as_json
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end



  private def like_params
    params.require(:like).permit(:state,:user_id,:likeable_id,:likeable_type)
  end

  private def find_like
    @like = Like.find(params[:id])
  end

  private def like_count
    @like.votes_count = 0
    @post.likes.each do |like|
      if like.state = true
        @post.increment!(:votes_count)
      end
    end
  end

end