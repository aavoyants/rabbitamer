require 'bunny'
require 'json'

require "rabbitamer/version"

require "rabbitamer/sender"
require "rabbitamer/configuration"
require "rabbitamer/connection"

module Rabbitamer
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end

require "rabbitamer/middleware"
