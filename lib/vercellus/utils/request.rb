# frozen_string_literal: true
require 'net/http'
require 'openssl'
require 'uri'

module Vercellus
  # Utility modules for Vercellus
  module Utils
    # Utility request module for Vercellus
    module Request
      module_function

      def get(url, params = {})
        url = URI("https://api.vercel.com/#{url}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer #{Vercellus.configuration.token}"

        response = http.request(request)
        JSON.parse(response.read_body)
      end

      def post(url, params = {}, body = {})
        response = Faraday.post(
          "https://api.vercel.com/#{url}",
          body: body.to_json,
          params: params,
          headers: {
            'Content-Type': "application/json",
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        JSON.parse(response.body)
      end

      def delete(url, params = {})
        response = Faraday.delete(
          "https://api.vercel.com/#{url}",
          params: params,
          headers: {
            'Content-Type': "application/json",
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        JSON.parse(response.body)
      end
    end
  end
end
