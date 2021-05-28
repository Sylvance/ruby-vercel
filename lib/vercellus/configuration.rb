# frozen_string_literal: true

module Vercellus

  # Adds global configuration settings to the gem, including:
  # 
  # * `config.token` - your Vercel token
  # 
  # To request token for Vercel, sign up for a free Vercel account and visit this page for instructions:
  # https://vercel.com/account/tokens
  # 
  # # Required fields
  # 
  # The following fields are *required* to use the gem:
  # 
  # - Token
  # 
  # The gem will raise a `Errors::Configuration` if you fail to provide these keys.
  # 
  # # Configuring your gem
  #
  # ```
  # Vercellus.configure do |config|
  #   config.token = ''
  # end
  # ```
  #
  # # Accessing configuration settings
  # 
  # All settings are available on the `Vercellus.configuration` object:
  # 
  # ```
  # Vercellus.configuration.token
  # ```
  # # Resetting configuration
  # 
  # To reset, simply call `Vercellus.reset`.
  # 
  class Configuration
    attr_writer :token

    def initialize
      @token = nil
    end

    def token
      raise Errors::Configuration, "Vercellus token missing!" unless @token
      @token
    end
  end
end
