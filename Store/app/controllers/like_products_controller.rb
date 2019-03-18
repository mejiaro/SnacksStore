class LikeProductsController < ApplicationController
  before_action :like, only: %i[index create like]
  def new; end

  def create
    prd = Product.find(params[:product])
    if @like.save
      redirect_back(fallback_location: root_path, flash: { alert: "Like given successfully to product #{prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location: root_path, flash: { alert: "Like was not given to product  #{prd.product_name}", alert_type: 'error' })
    end
  end

  def destroy
    prd = Product.find(params[:id])
    @delete = LikeProduct.destroy(@like.id)
    if @delete.destroy
      redirect_back(fallback_location: root_path, flash: { alert: "Like deleted successfully to product  #{prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location: root_path, flash: { alert: "Like was not deleted to product  #{prd.product_name}", alert_type: 'error' })
    end
  end

  private

  def like
    @like =
      if action_name == 'new'
        LikeProduct.new
      elsif %w[create destroy].includes?(action_name)
        LikeProduct.find_by(user_id: current_user.id, product_id: params[:id])
      end
  end
end
