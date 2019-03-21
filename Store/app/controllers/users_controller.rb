class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, :users, :comments
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
        @user.comments.where(status: 'A')
      end
  end

  def users
    @users = User.where(role: 2)
  end

  def user
    @user =
      if params[:id].present?
        User.find(params[:id])
      else
        current_user
      end
  end
end
