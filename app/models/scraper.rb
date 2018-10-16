class Scraper < ApplicationRecord
  DEFAULT_PARAMS = { by: 'relevancy', order: 'desc' }.freeze
  DEFAULT_URL = 'https://shopee.tw/api/v2/search_items/'.freeze

  def search_response
    search_request['items']
  end

  private

  def search_request
    HTTP.get(DEFAULT_URL, search_params, device)
  end

  def search_params
    { keyword: keyword, limit: limit.to_i }.merge(DEFAULT_PARAMS)
  end
end
