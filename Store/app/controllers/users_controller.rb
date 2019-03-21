class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :comments
  helper_method :comments
  # before_action :admin_only, except: :show

  def index; end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
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
        Comment.find(params[:id])
      end
  end
end
