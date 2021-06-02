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

      BASE_URL = "https://api.vercel.com/"

      def get(url)
        uri = URI("#{BASE_URL}#{url}")
        http = setup_http(uri)
        request = setup_request(uri, "Get")

        response = http.request(request)
        JSON.parse(response.read_body)
      end

      def post(url, body, x_now_digest = nil)
        uri = URI("#{BASE_URL}#{url}")
        http = setup_http(uri)
        request = setup_request(uri, "Post")
        body = body.is_a?(Hash) ? JSON.dump(body) : body
        request.body = body
        request["X-Now-Digest"]  = x_now_digest if x_now_digest

        response = http.request(request)
        JSON.parse(response.read_body)
      end

      def patch(url)
        uri = URI("#{BASE_URL}#{url}")
        http = setup_http(uri)
        request = setup_request(uri, "Patch")

        response = http.request(request)
        JSON.parse(response.read_body)
      end

      def delete(url)
        uri = URI("#{BASE_URL}#{url}")
        http = setup_http(uri)
        request = setup_request(uri, "Delete")

        response = http.request(request)
        JSON.parse(response.read_body)
      end

      private

        def setup_http(uri)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http
        end

        def setup_request(uri, type)
          request = "Net::HTTP::#{type}.new(#{uri})".constantize
          request["Authorization"] = "Bearer #{Vercellus.configuration.token}"
          request["Content-Type"]  = 'application/json' if type == "Post"
          request
        end
    end
  end
end
