class LikeProductsController < ApplicationController
  def new
    @like = LikeProduct.new
  end

  def create
    usr = User.find(current_user.id)
    prd = Product.find(params[:product])
    @like = LikeProduct.new(user: usr, product: prd)
    if @like.save
      redirect_back(fallback_location: root_path, flash: { alert: "Like given successfully to product #{prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location: root_path, flash: { alert: "Like was not given to product  #{prd.product_name}", alert_type: 'error' })
    end
  end

  def destroy
    usr = User.find(current_user.id)
    prd = Product.find(params[:product])
    @like = LikeProduct.find_by(user: usr, product: prd)
    @delete = LikeProduct.destroy(@like.id)
    if @delete.destroy
      redirect_back(fallback_location: root_path, flash: { alert: "Like deleted successfully to product  #{prd.product_name}", alert_type: 'success' })
    else
      redirect_back(fallback_location: root_path, flash: { alert: "Like was not deleted to product  #{prd.product_name}", alert_type: 'error' })
    end
  end
end
