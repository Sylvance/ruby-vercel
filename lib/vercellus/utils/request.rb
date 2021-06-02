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

      def post(url, body, headers)
        uri = URI("#{BASE_URL}#{url}")
        http = setup_http(uri)
        request = setup_request(uri, "Post", body, headers)

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

        def setup_request(uri, type, body = nil, headers = nil)
          request = Object.const_get("Net::HTTP::#{type}.new(#{uri})")
          request["Authorization"] = "Bearer #{Vercellus.configuration.token}"
          request["Content-Type"]  = 'application/json' if type == "Post"
          request = build_headers(request, headers) unless headers.nil?
          request.body = body unless body.nil?
          request
        end

        def build_headers(request, headers)
          request["X-Now-Digest"]  = headers['x_now_digest'] if headers.key?('x_now_digest')
          request["Content-Length"]  = headers['content_length'] if headers.key?('content_length')
          request
        end
    end
  end
end
