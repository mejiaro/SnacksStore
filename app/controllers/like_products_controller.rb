class LikeProductsController < ApplicationController
  before_action :user_only, only: %i[create destroy]
  before_action :product_name, only: %i[create destroy like]
  before_action :like, only: %i[new create destroy]
  def new; end

  def create
    if @like.save
      redirect_back(fallback_location:
        root_path, flash: { alert: "Like given successfully to product
          #{@prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location:
        root_path, flash: { alert: "Like was not given to product
          #{@prd.product_name}", alert_type: 'error' })
    end
  end

  def destroy
    @delete = LikeProduct.destroy(@like.id)
    if @delete.destroy
      redirect_back(fallback_location:
         root_path, flash: { alert: "Like deleted successfully to product
           #{@prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location:
         root_path, flash: { alert: "Like was not deleted to product
           #{@prd.product_name}", alert_type: 'error' })
    end
  end

  private

  def like
    @like =
      if action_name == 'new'
        LikeProduct.new
      elsif action_name == 'create'
        LikeProduct.new(user_id: current_user.id, product_id: @prd.id)
      else
        LikeProduct.find_by(user_id: current_user.id, product_id: @prd.id)
      end
  end

  def product_name
    @prd = Product.find(params[:id])
  end
end
