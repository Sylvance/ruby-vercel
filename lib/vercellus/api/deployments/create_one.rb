# frozen_string_literal: true

module Vercellus
  # # Post the authenticated user
  #
  # Posts the authenticated user `https://vercel.com/docs/api#endpoints/deployments/create-a-new-deployment`:
  #
  # ```
  # Vercellus::API::Deployments::CreateOne.post(body, metadata, x_now_digest)
  # ```
  #
  module API
    module Deployments
      class CreateOne
        def self.post(body, metadata, x_now_digest)
          new(body, metadata, x_now_digest).post
        end

        def initialize(body, metadata, x_now_digest)
          @body = body
          @metadata = metadata
          @x_now_digest = x_now_digest
        end

        def get
          url = 'v12/now/deployments'
          Vercellus::Utils::Request.post(url, @body, @x_now_digest)
        end
      end
    end
  end
end
