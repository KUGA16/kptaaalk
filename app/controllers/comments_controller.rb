class CommentsController < ApplicationController
  def index
    @comment_new = Comment.new
  end

  def new
  end

  def create
    @comment_new = Comment.new(comment_params)
    if @comment_new.save!
       render :success
    else
       render :error
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:place_status)
  end
end
