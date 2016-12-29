module Rabbitamer
  class Configuration
    attr_accessor :connection, :actions, :message, :queue

    def initialize
      @connection = {}
      @actions = []
    end
  end
end
