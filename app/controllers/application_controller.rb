class ApplicationController < ActionController::Base
  include Pagy::Backend
  skip_forgery_protection

  private

  def is_crsf_token_valid?
    request.headers["X-CSRF-TOKEN"] === Digest::MD5.hexdigest(Date.today.strftime("%Y/%m/%d"))
  end
end