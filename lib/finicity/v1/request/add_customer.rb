module Finicity::V1
  module Request
    class AddCustomer
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
      def initialize(token, user_guid)
        @token = token
        @user_guid = user_guid
      end

      def add_customer
        http_client.post(url, body, headers)
      end

      def body
        {
          'username' => user_guid,
          'email' => "#{user_guid}@mx.com",
          'firstName' => user_guid,
          'lastName' => user_guid
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
          'active'
        )
      end
    end
  end
end
