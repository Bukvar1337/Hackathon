class Api::CommentsController < ApplicationController
  before_action :find_comment, only: [:update, :destroy]

  def index
    @comments = Comment.all
    render json: @comments.as_json
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment.as_json
    else
      render json: { success: false, errors: @comment.errors.as_json }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to users_path
  end

  def update
    if(@comment.update(comment_params))
      render json: @comment.as_json
    else
      render json: { success: false, errors: @comment.errors.as_json }, status: :unprocessable_entity
    end
  end

  private def comment_params
    params.require(:comment).permit(:body,:user_id,:commentable_id,:commentable_type)
  end

  private def find_comment
    @comment = Comment.find(params[:id])
  end

end

