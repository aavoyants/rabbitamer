module Rabbitamer
  class Middleware
    class << self
      attr_accessor :env
    end

    AVAILABLE_ACTIONS = ['send', 'receive']

    def call(env)
      self.class.env = env

      @actions.each do |action|
        instance_eval(action) if AVAILABLE_ACTIONS.include?(action)
      end

      @app.call(env)
    end

  private

    def initialize(app)
      Rabbitamer.configure {} unless Rabbitamer.configuration
      @app = app
      @actions = Rabbitamer.configuration.actions
    end

    def send
      Connection.init
      Sender.call
      Connection.close
    rescue
      # TODO
    end

    def receive
      # TODO
    end
  end
end
