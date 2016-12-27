module Rabbitamer
  class Connection
    class << self
      def init
        @connection = Bunny.new(Rabbitamer.configuration.connection)
        @connection.start
      end

      def close
        @connection.close
      end

      def create_channel
        @connection.create_channel
      end
    end
  end
end
