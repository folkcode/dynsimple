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
      url = "https://dnsimple.com/domains/#{config[:domain]}/records/#{config[:record]}"
      headers = {
        'Accept'                  => 'application/json',
        'Content-Type'            => 'application/json',
        'X-DNSimple-Domain-Token' => config[:token]
      }
      ip = HTTParty.get('http://ip4.icanhazip.com/').body.strip
      body = "{ \"record\": { \"content\": \"#{ip}\" } }"
      HTTParty.put(url, :headers => headers, :body => body)
    end
  end
end
