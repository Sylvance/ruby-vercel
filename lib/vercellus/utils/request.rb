module Vercellus
  module Utils
    module Request
      extend self

      def get(url, key, params={})
        response = Faraday.get(
          "https://api.vercel.com/#{url}",
          params: params,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        data = JSON.parse(response.body)
        return data[key] if key
        return data
      end

      def post(url, params={}, body={})
        response = Faraday.post(
          "https://api.vercel.com/#{url}",
          body: body.to_json,
          params: params,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        data = JSON.parse(response.body)
        return data
      end

      def delete(url, key, params={})
        response = Faraday.delete(
          "https://api.vercel.com/#{url}",
          params: params,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer #{Vercellus.configuration.token}"
          }
        )

        data = JSON.parse(response.body)
        return data[key] if key
        return data
      end
    end
  end
end
