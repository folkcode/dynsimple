require 'spec_helper'

module DynSimple
  describe CLI do
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
          and_return(double(:body => "1.2.3.4\n"))
        HTTParty.should_receive(:put).
          with(url, :headers => headers, :body => body)
        argv = %w(--domain example.com --token deadbeef --record 42)
        CLI.run(argv)
      end
    end
  end
end
