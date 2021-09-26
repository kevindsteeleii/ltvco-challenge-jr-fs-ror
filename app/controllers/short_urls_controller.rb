class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @short_codes = ShortUrl.order(click_count: :desc).limit(100).map do |short_url| 
      short_url.short_code
    end

    render json: {urls: @short_codes}
  end

  def create
    @short_url = ShortUrl.new(short_url_params)
    if @short_url.valid? 
      @short_url.save!
      UpdateTitleJob.perform_later(@short_url.id)
      render json: { short_code: @short_url.short_code }
    else
      render json: { errors: "Full url is not a valid url" }
    end
  end

  def show
  end

  private

  def short_url_params 
    params.permit(:full_url, :id)
  end

end
