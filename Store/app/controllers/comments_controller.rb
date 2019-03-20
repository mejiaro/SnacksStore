class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :user_only, only: %i[create]
  def index; end

  def show; end

  def create
    @comment =
      if @commentable.class == Product
        @commentable.comments.new(allowed_product_params)
      else
        @commentable.comments.new(allowed_user_params)
      end
    if @comment.save
      redirect_back(fallback_location:
        root_path, flash: { alert: 'Comment create', alert_type: 'success' })
    else
      redirect_back(fallback_location:
        root_path, flash: { alert: 'Comment not create', alert_type: 'danger' })
    end
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def allowed_product_params
    params.require(:comment).permit(:review).merge(
      user_id: current_user.id, status: 'A'
    )
  end

  def allowed_user_params
    params.require(:comment).permit(:review).merge(
      user_id: current_user.id, status: 'D'
    )
  end
end
