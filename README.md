# Rabbitamer

Rabbitamer is a Rack middleware which (for now) can send messages to RabbitMQ's named queues. Uses `bunny` Ruby client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rabbitamer', github: 'aavoyants/rabbitamer'
```

And then execute:

    $ bundle

## Usage

Just add to `config.ru`:

```ruby
use Rabbitamer::Middleware
```

You have to configure `rabbitamer` by addind the `rabbitamer.rb` to `initializers` folder:

```ruby
Rabbitamer.configure do |config|
  config.connection = { host: 'host', port: 'port', ... } # bunny connections settings, optional
  config.actions = ['send'] # mandatory: actions you want your app to call
  config.message = 'message' # mandatory: message text or your method (or proc) returning the message text
  config.queue = 'queue-name' # mandatory: queue name
end
```

If there is no `message` parameter the whole request will be used as a message.
All `bunny` connection parameters you can find [here](http://rubybunny.info/articles/connecting.html#using_a_map_of_parameters).
Gem responds to only 'send' and 'receive' actions (`actions` param), but 'receive' is not implemented.

## TODO

Implement `receive` queue action.
