module Rabbitamer
  class Middleware
    AVAILABLE_METHODS = ['send', 'receive']

    def call(env)
      @params.merge!({ message: env.to_json }) unless @params[:message]

      @methods.each do |method|
        instance_eval(method) if AVAILABLE_METHODS.include?(method)
      end

      @app.call(env)
    end

  private

    def initialize(app, methods = [], params = {})
      @app = app
      @methods = methods
      @params = params
    end

    def send
      Connection.init
      Sender.call(@params)
      Connection.close
    end

    def receive
      # TODO
    end
  end
end
