class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    # 1. query short_urls that match the description (top 100 click_count, descending short_urls)
    # 2. map query to #short_code and assign to @short_codes variable
    # 3. render @short_codes as a json with structure that matches Rspec test
    @short_codes = ShortUrl.order(click_count: :desc).limit(100).map do |short_url| 
      short_url.short_code
    end

    render json: {urls: @short_codes}
  end

  def create
  end

  def show
  end

end
