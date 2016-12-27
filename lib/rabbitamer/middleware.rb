module Rabbitamer
  class Middleware
    def call(env)
      if !!@method
        @params.merge!({ message: env.to_json }) unless @params[:message]

        Connection.init
        instance_eval(@method)
        Connection.close
      end

      @app.call(env)
    end

  private

    def initialize(app, method, params = {})
      @app = app
      @method = method
      @params = params
    end

    def send
      Sender.call(@params)
    end

    def receive
      # TODO
    end
  end
end
