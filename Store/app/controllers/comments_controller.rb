class CommentsController < ApplicationController
  before_action :load_commentable
  def index; end

  def show; end

  def create
    # puts @commentable.class
    @comment =
      if @commentable.class.is_a?(Product)
        @commentable.comments.new(allowed_product_params)
      else
        @commentable.comments.new(allowed_user_params)
      end
    if @comment.save
      redirect_to [@commentable, :comments], notice: 'Comment created'
    else
      render :new
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def allowed_product_params
    puts params
    params.require(:comment).permit(:review).merge(
      user_id: current_user.id, status: 'A'
    )
  end

  def allowed_user_params
    puts params
    params.require(:comment).permit(:review).merge(
      user_id: current_user.id, status: 'D'
    )
  end
end
