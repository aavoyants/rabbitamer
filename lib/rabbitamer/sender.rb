module Rabbitamer
  class Sender
    def self.call
      channel = Connection.create_channel
      queue_name = Rabbitamer.configuration.queue

      if queue_name
        queue = channel.queue(queue_name, durable: true, auto_delete: false)
        queue.publish(payload, persistent: true)
      end
    end

  private

    def self.payload
      message = Rabbitamer.configuration.message || Rabbitamer::Middleware.env
      (message.is_a?(Proc) ? message.call : message).to_json
    end
  end
end
