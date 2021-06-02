# frozen_string_literal: true

module Vercellus
  # # Get the authenticated user
  #
  # Gets the authenticated user `https://vercel.com/docs/api#endpoints/user/get-the-authenticated-user`:
  #
  # ```
  # Vercellus::API::User.get
  # ```
  #
  module API
    class User
      def self.get
        new.get
      end

      def initialize; end

      def get
        url = 'www/user'
        ::Vercellus::Utils::Request.get(url)
      end
    end
  end
end
