class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    # find short_url by id
    # invoke #update_title!
    short_url = ShortUrl.find(short_url_id)
    short_url.update_title!
  end
end
