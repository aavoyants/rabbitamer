require 'bunny'

require "rabbitamer/version"

require "rabbitamer/sender"
require "rabbitamer/configuration"
require "rabbitamer/connection"
require "rabbitamer/middleware"

module Rabbitamer
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end

