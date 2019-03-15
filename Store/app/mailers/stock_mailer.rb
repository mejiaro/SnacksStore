class StockMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_notification_mail(product)
    @product = product
    @user = product.like_products.order(:created_at).last.user
    attachments['product.jpg'] = { mime_type: 'image/jpeg', content: product.image.download }
    mail(to: @user.email, subject: "The product #{@product.product_name} is almost out of stock!!")
  end
end
