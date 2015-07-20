module Finicity::V1
  module Request
    class GetCustomers
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
        client.proxy = ENV['QUOTAGUARDSTATIC_URL'] if Rails.env.production?
      end

      ##
      # Attributes
      #
      attr_accessor :token

      ##
      # Instance Methods
      #
      def initialize(token)
        @token = token
      end

      def get_customers(start, limit, type)
        query = { :start => start, :limit => limit, :type => type }
        http_client.get(url, query, headers)
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token
        }
      end

      def url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers'
        )
      end
    end
  end
end
