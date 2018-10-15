require 'net/http'
require 'json'
class InvalidRequest < StandardError; end

class HTTP
  def self.get(url, params, device)
    # params = {limit: 100, by: 'relevancy', keyword: 'xxx', order: 'desc'}
    # device = 'pc' || 'rweb'
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(uri)
    req['x-api-source'] = device
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true){|http|
      http.request(req)
    }
    parsed_response = JSON.parse(response.body)
    raise InvalidRequest, parsed_response['error']['message'] if response.code != '200'

    parsed_response
  end
end