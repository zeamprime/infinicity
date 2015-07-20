module Finicity::V1
  module Request
    class AddCustomer
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
        client.proxy = ENV['QUOTAGUARDSTATIC_URL'] if Rails.env.production?
      end

      ##
      # Attributes
      #
      attr_accessor :token, :username, :finicity_user_type, :first_name, :last_name

      ##
      # Instance Methods
      #
      def initialize(token, username, first_name, last_name, finicity_user_type)
        @token = token
        @username = username
        @first_name = first_name
        @last_name = last_name
        @finicity_user_type = finicity_user_type.nil? ? :active : finicity_user_type
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
        path = @finicity_user_type == :active ? 'active' : 'testing'
        ::URI.join(::Finicity.config.base_url,'v1/',"customers/#{path}")
      end
    end
  end
end
