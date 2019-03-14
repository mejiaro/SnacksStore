class StockMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def send_notification_mail(product)
    @product = product

    mail(to: 'cemg_neto@hotmail.com', subject: "The product #{@product.product_name} is almost out of stock!!")
    @cover_url = rails_blob_url(@product.image, disposition: 'attachment', only_path: true)
  end
end
