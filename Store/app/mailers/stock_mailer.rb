class StockMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_notification_mail(product)
    @product = product
    like = LikeProduct.where(product_id: product.id).last
    @user = User.find(like.user_id)
    mail(to: @user.email, subject: "The product #{@product.product_name} is almost out of stock!!")
  end
end
