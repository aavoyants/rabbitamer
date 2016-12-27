module Rabbitamer
  class Configuration
    attr_accessor :connection

    def initialize
      @connection = {}
    end
  end
end
