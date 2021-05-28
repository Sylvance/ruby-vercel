# frozen_string_literal: true

module Vercellus
  # Utility modules for Vercellus
  module Utils
    # Utility request module for Vercellus
    module Request
      module_function

      def get(url, params = {})
        response = Faraday.get(
          "https://api.vercel.com/#{url}",
          params: params,
          headers: {
            'Content-Type': "application/json",
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        JSON.parse(response.body)
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
