module Finicity::V1
  module Request
    class GetInstitutions
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
        client.proxy = ENV['QUOTAGUARDSTATIC_URL'] if Rails.env.production?
      end

      ##
      # Attributes
      #
      attr_accessor :institution_name,
        :token

      ##
      # Instance Methods
      #
      def initialize(token, institution_name)
        @institution_name = institution_name
        @token = token
      end

      def get_institutions(start, limit)
        query = { :start => start, :limit => limit, :search => institution_name }
        include_http_client.get(url, query, headers)
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
          'institutions'
        )
      end
    end
  end
end
