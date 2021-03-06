# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rabbitamer/version'

Gem::Specification.new do |spec|
  spec.name          = "rabbitamer"
  spec.version       = Rabbitamer::VERSION
  spec.authors       = ["Anatoly Avoyants"]
  spec.email         = ["aavoyants@gmail.com"]

  spec.summary       = 'Sending/receiving AMQP messages'
  spec.description   = 'Rack middleware for sending and receiving messages to RabbitMQ using bunny'
  spec.homepage      = "https://github.com/aavoyants/rabbitamer/"
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.0'

  spec.add_dependency "bunny", "~> 2.6.2"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bunny-mock"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "pry"
end
