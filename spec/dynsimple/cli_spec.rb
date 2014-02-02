require 'spec_helper'

module DynSimple
  describe CLI do
    describe '#logger' do
      let(:cli) { CLI.new }
      let(:logger) { double('logger') }

      it 'initializes and returns a logger' do
        Cabin::Channel.should_receive(:new).once.and_return(logger)
        logger.should_receive(:subscribe).with(STDOUT)
        2.times { expect(cli.logger).to be logger }
      end
    end

    describe '.run' do
      it 'starts the party' do
        url = 'https://dnsimple.com/domains/example.com/records/42'
        headers = {
          'Accept'                  => 'application/json',
          'Content-Type'            => 'application/json',
          'X-DNSimple-Domain-Token' => 'deadbeef'
        }
        body = '{ "record": { "content": "1.2.3.4" } }'
        HTTParty.should_receive(:get).
          with('http://ip4.icanhazip.com/').
          and_return(double(:body => "1.2.3.4\n", :code => 200))
        HTTParty.should_receive(:put).
          with(url, :headers => headers, :body => body).
          and_return(double(:body => '', :code => 200))
        argv = %w(--domain example.com --token deadbeef --record 42)
        CLI.run(argv)
      end
    end
  end
end
