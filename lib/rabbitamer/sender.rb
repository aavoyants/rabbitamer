module Rabbitamer
  class Sender
    def self.call
      channel = Connection.create_channel
      message = Rabbitamer.configuration.message || Rabbitamer::Middleware.env
      queue_name = Rabbitamer.configuration.queue

      if queue_name
        queue = channel.queue(queue_name, durable: true, auto_delete: false)
        queue.publish(message.to_json, persistent: true)
      end
    end
  end
end
