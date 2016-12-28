module Rabbitamer
  class Middleware
    class << self
      attr_accessor :env
    end

    AVAILABLE_METHODS = ['send', 'receive']

    def call(env)
      self.class.env = env

      @methods.each do |method|
        instance_eval(method) if AVAILABLE_METHODS.include?(method)
      end

      @app.call(env)
    end

  private

    def initialize(app)
      @app = app
      @methods = Rabbitamer.configuration.methods
    end

    def send
      Connection.init
      Sender.call
      Connection.close
    end

    def receive
      # TODO
    end
  end
end
