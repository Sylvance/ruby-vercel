# frozen_string_literal: true

module Vercellus
  # # Post the authenticated user
  #
  # Posts the authenticated user `https://vercel.com/docs/api#endpoints/deployments/create-a-new-deployment`:
  #
  # ```
  # Vercellus::API::Deployments::UploadFiles.post(body, headers)
  # ```
  #
  module API
    module Deployments
      class UploadFiles
        def self.post(body, headers)
          new(body, headers).post
        end

        def initialize(body, headers)
          @body = body
          @headers = headers
        end

        def get
          url = 'v2/now/files'
          body = body.is_a?(Hash) ? JSON.dump(body) : body
          Vercellus::Utils::Request.post(url, @body, @headers)
        end
      end
    end
  end
end
