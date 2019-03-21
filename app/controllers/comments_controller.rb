class CommentsController < ApplicationController
  before_action :load_commentable
  before_action :user_only, only: %i[create]
  before_action :comment
  def index; end

  def show; end

  def create
    if @comment.save
      if @commentable.class == Product
        success_back('Comment created')
      else
        success_back('Comment created, please wait for approval')
      end
    else
      error_back('Comment not create')
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to users_path, notice: 'User deleted.'
  end

  def edit; end

  def update
    @comment.status = if @comment.status == 'D'
                        'A'
                      else
                        'D'
                      end
    if @comment.save
      success(users_path, 'Status changed')
    else
      error(users_path, 'Status wasn\'t changed')
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

  def comment
    @comment =
      if action_name == 'create'
        if @commentable.class == Product
          @commentable.comments.new(allowed_product_params)
        else
          @commentable.comments.new(allowed_user_params)
        end
      elsif %w[update edit show destroy].include?(action_name)
        Comment.find(params[:id])
      else
        Comment.where(status: 'A')
      end
  end
end
