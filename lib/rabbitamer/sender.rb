module Rabbitamer
  class Sender
    def self.call(params)
      channel = Connection.create_channel
      queue = channel.queue(params[:queue], durable: true, auto_delete: false)
      queue.publish(params[:message], persistent: true)
    end
  end
end
