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
use Rabbitamer::Middleware, ['send'], queue: 'queue-name'
```

First param is methods list you want your app to call. For now it's only 'send' and 'receive' (and 'receive' is not implemented yet). Second param is a Hash with 'queue' and 'message' params. If there is no `message` parameter the whole request will be used as a message. To send something different you can use:

```ruby
use Rabbitamer::Middleware, ['send'], queue: 'queue-name', message: 'message-text'
```
or

```ruby
use Rabbitamer::Middleware, ['send'], queue: 'queue-name', message: Proc.new { ... }
```

Also you can configure `bunny` connection options addind the `rabbitamer.rb` to `initializers` folder:

```ruby
Rabbitamer.configure do |config|
  config.connection = { host: 'host', port: 'port', ... }
end
```

All parameters you can find [here](http://rubybunny.info/articles/connecting.html#using_a_map_of_parameters).

## TODO

Implement `read` queue method.
