require "mercury_web_parser/version"
require "json"
require "ostruct"
require "rest_client"

module MercuryWebParser
  API_ENDPOINT = "https://mercury.postlight.com/parser".freeze

  class << self
    attr_accessor :api_token
  end

  def self.parse(url)
    resp = RestClient.get(API_ENDPOINT, params: { url: url },
                          "x-api-key" => api_token, accept: :json)

    OpenStruct.new(JSON[resp])
  end
end
