class StockMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_notification_mail(product)
    @product = product
    #like = LikeProduct.find_by(product_id: product.id).last
    #@user = User.find(like.user_id)
    mail(to: 'cemg_neto@hotmail.com', subject: "The product #{@product.product_name} is almost out of stock!!")
  end
end
