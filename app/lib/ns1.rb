# Documentation for the NS1 API can be found at
# https://ns1.com/api
module Ns1
  class Base
    BASE_URL = 'https://api.nsone.net/v1'.freeze

    def self.read(url)
      Typhoeus::Request.new(
        BASE_URL + url,
        method: :get,
        headers: headers
      ).run
    end

    def self.write(url, method, body)
      Typhoeus::Request.new(
        BASE_URL + url,
        method: method,
        body: body.to_json,
        headers: headers
      ).run
    end

    def self.delete(url)
      Typhoeus::Request.new(
        BASE_URL + url,
        method: :delete,
        headers: headers
      ).run
    end

    def self.headers
      { 'X-NSONE-Key' => ENV['NS1_KEY'] }
    end
  end
end
