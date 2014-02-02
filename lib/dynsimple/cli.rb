module DynSimple
  class CLI
    include Mixlib::CLI

    option :domain,
      :long => '--domain DOMAIN_ID'

    option :token,
      :long => '--token DOMAIN_TOKEN'

    option :record,
      :long => '--record RECORD_ID'

    def self.run(argv=ARGV)
      new.run(argv)
    end

    def run(argv)
      parse_options(argv)
      get_public_address
      update_record
    end

    def get_public_address
      response = nil
      url = 'http://ip4.icanhazip.com/'
      logger.time('Fetch public IP address') do
        response = HTTParty.get(url)
      end
      logger.info('HTTP API Response', :url => url, :code => response.code, :body => response.body)
      @address = response.body.strip
    end

    def update_record
      url = "https://dnsimple.com/domains/#{config[:domain]}/records/#{config[:record]}"
      headers = {
        'Accept'                  => 'application/json',
        'Content-Type'            => 'application/json',
        'X-DNSimple-Domain-Token' => config[:token]
      }
      body = "{ \"record\": { \"content\": \"#{@address}\" } }"
      response = nil
      logger.time('Update domain record') do
        response = HTTParty.put(url, :headers => headers, :body => body)
      end
      logger.info('HTTP API Response', :url => url, :code => response.code, :body => response.body)
    end

    def logger
      @logger ||= create_logger
    end

  private

    def create_logger
      channel = Cabin::Channel.new
      channel.subscribe(STDOUT)
      channel
    end
  end
end
