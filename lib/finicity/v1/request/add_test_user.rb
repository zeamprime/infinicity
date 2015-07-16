module Finicity::V1
  module Request
    class AddTestUser
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
      end

      ##
      # Attributes
      #
      attr_accessor :token,
        :user_guid

      ##
      # Instance Methods
      #
      def initialize(token, username, first_name, last_name)
        @token = token
        @username = username
        @first_name = first_name
        @last_name = last_name
      end

      def add_customer
        http_client.post(url, body, headers)
      end

      def body
        {
          'username' => @username,
          'firstName' => @first_name,
          'lastName' => @last_name
        }.to_xml(:root => 'customer')
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token,
          'Content-Type' => 'application/xml'
        }
      end

      def url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers/',
          'testing'
        )
      end
    end
  end
end
