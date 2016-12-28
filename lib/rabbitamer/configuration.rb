module Rabbitamer
  class Configuration
    attr_accessor :connection, :methods, :message, :queue

    def initialize
      @connection = {}
      @methods = []
    end
  end
end
