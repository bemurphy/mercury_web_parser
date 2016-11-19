require "mercury_web_parser/version"
require "json"
require "net/https"
require "ostruct"
require "uri"

module MercuryWebParser
  API_ENDPOINT = "https://mercury.postlight.com/parser".freeze

  class << self
    attr_accessor :api_key
  end

  def self.parse(url)
    uri = URI("#{API_ENDPOINT}?url=#{url}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/json"
      request["x-api-key"] = api_key
      http.request(request)
    end

    OpenStruct.new(JSON[response.body])
  end
end
