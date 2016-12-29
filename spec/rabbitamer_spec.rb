require "spec_helper"

describe Rabbitamer do
  subject { Rabbitamer::Middleware.new(app) }

  let(:app)          { ->(env) { [200, env, "app"] } }
  let(:actions)      { [] }
  let(:queue)        { nil }
  let(:connection)   { nil }
  let(:message)      { nil }

  before do
    @session = BunnyMock.new
    allow(Bunny).to receive(:new).and_return(@session)
    configure
  end

  context 'when connection is configured' do
    let(:actions)     { ['send'] }
    let(:connection)  { { host: 'localhost' } }

    it 'uses the configured connection params' do
      expect(Bunny).to receive(:new).with(connection)
      subject.call(env_for('http://admin.example.com'))
    end
  end

  context 'when connection is not configured' do
    let(:actions)     { ['send'] }

    it 'uses the default connection params' do
      expect(Bunny).to receive(:new).with(nil)
      subject.call(env_for('http://admin.example.com'))
    end
  end

  context 'when actions list and queue name are not configured' do
    it 'does not start a connection to RabbitMQ' do
      expect(Bunny).not_to receive(:new)
      subject.call(env_for('http://admin.example.com'))
    end
  end

  context 'when actions list is not configured and queue name is' do
    let(:queue) { 'queue' }

    it 'does not start a connection to RabbitMQ' do
      expect(Bunny).not_to receive(:new)
      subject.call(env_for('http://admin.example.com'))
    end
  end

  context 'when actions list is configured and queue name is not' do
    context "when actions include 'send'" do
      let(:actions) { ['send'] }

      it 'starts a connection to RabbitMQ' do
        expect(Bunny).to receive(:new)
        subject.call(env_for('http://admin.example.com'))
      end

      it 'does not send message' do
        subject.call(env_for('http://admin.example.com'))
        expect(@session.queues).to be_empty
      end
    end

    context "when actions include 'receive'" do
      it 'does not start a connection to RabbitMQ' do
        expect(Bunny).not_to receive(:new)
        subject.call(env_for('http://admin.example.com'))
      end
    end
  end

  context 'when actions list and queue name are both configured' do
    let(:queue)   { 'queue' }

    context "when actions include 'send'" do
      let(:actions) { ['send'] }

      it 'starts a connection to RabbitMQ' do
        expect(Bunny).to receive(:new)
        subject.call(env_for('http://admin.example.com'))
      end

      it 'sends a message to the queue' do
        subject.call(env_for('http://admin.example.com'))
        expect(@session.queue_exists?(queue)).to be_truthy
      end

      describe 'message content' do
        before { subject.call(env_for('http://admin.example.com')) }

        let(:payload) { @session.queues[queue].pop.last }

        context 'when message is configured' do
          let(:message) { 'message' }

          it 'sends the configured message' do
            expect(payload).to eq(message.to_json)
          end
        end

        context 'when message is not configured' do
          it 'sends the whole middleware ENV' do
            expect(payload).to eq(Rabbitamer::Middleware.env.to_json)
          end
        end
      end
    end

    context "when actions include 'receive'" do
      it 'does not start a connection to RabbitMQ' do
        expect(Bunny).not_to receive(:new)
        subject.call(env_for('http://admin.example.com'))
      end
    end
  end

  def env_for(url, opts={})
    Rack::MockRequest.env_for(url, opts)
  end

  def configure
    Rabbitamer.configure do |config|
      config.actions = actions
      config.queue = queue
      config.connection = connection
      config.message = message
    end
  end
end
