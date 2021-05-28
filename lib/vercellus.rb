# frozen_string_literal: true
require 'json'
require 'faraday'

require_relative 'vercellus/configuration'
require_relative 'vercellus/errors/configuration'
require_relative "vercellus/utils/request"
require_relative "vercellus/version"

module Vercellus
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
