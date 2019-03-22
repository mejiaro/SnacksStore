class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, :exist, :users, :comments
  helper_method :user, :users, :comments
  # before_action :admin_only, except: :show

  def index; end

  def show
    @comment = @user.comments.new
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

  def comments
    @comments =
      if action_name == 'index'
        Comment.all.where("commentable_type='User'")
      else
        @user.comments.where(status: 'A').includes(:user)
      end
  end

  def users
    @users = User.where(role: :user)
  end

  def user
    @user =
      if params[:id].present?
        User.find_by(id: params[:id])
      else
        current_user
      end
  end

  def exist
    error(user_path(id: current_user.id), 'User not available') unless @user
  end
end
