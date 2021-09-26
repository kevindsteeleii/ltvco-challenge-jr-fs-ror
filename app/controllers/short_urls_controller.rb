class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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
    @short_url = ShortUrl.find_by_short_code(params[:id])

    @short_url.tap do |short_url| 
      short_url.click_count += 1
    end

    @short_url.save!
    redirect_to @short_url.full_url
  end

  private

  def record_not_found 
    render plain: "404 Not Found", status: 404
  end

  def short_url_params 
    params.permit(:full_url, :id)
  end

end
