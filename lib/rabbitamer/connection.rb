module Rabbitamer
  class Connection
    class << self
      def init
        @connection = Bunny.new
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
