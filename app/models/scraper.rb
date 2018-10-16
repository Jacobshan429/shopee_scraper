# frozen_string_literal: true

class Scraper < ApplicationRecord
  DEFAULT_PARAMS = { by: 'relevancy', order: 'desc' }.freeze
  DEFAULT_URL = 'https://shopee.tw/api/v2/search_items/'

  def reformat_response
    items = search_response
    items_res = items.map do |item|
      Shop.find_by(uid: item['shopid']) ? item_hash(items, item) : nil
    end
    if items_res.compact.empty?
      [{ error: 'no target shop found' }]
    else
      items_res.compact.map do |item_res|
        item_res.merge(
          shop_name: Shop.find_by(uid: item_res[:shop_id]).name
        )
      end
    end
  end

  private

  def search_request
    HTTP.get(DEFAULT_URL, search_params, device)
  end

  def search_params
    { keyword: keyword, limit: limit.to_i }.merge(DEFAULT_PARAMS)
  end

  def search_response
    search_request['items']
  end

  def item_hash(items, item)
    {
      shop_id: item['shopid'],
      item_id: item['itemid'],
      ranking: items.find_index(item) + 1,
      name: item['name'].truncate(20),
      link: "https://shopee.tw/item-i.#{item['shopid']}.#{item['itemid']}",
      keyword: keyword,
      device: device
    }
  end
end
