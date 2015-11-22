module Finicity::V2
  module Request
    class GetTransactions
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
      end

      ##
      # Attributes
      #
      attr_accessor :account_id, # If nil, fetches for all accounts
        :customer_id,
        :from_date,
        :to_date,
        :start, #optional
        :limit,	#optional
        :sort,	#optional
        :token

      ##
      # Instance Methods
      #
      def initialize(token, customer_id, account_id, from_date, to_date, 
      		start = 1, limit = 1000, sort = "desc")
        @account_id = account_id 	#can be nil, will fetch for all accounts.
        @customer_id = customer_id
        @from_date = from_date
        @to_date = to_date
        @start = start
        limit = 1000 if limit > 1000 # this is the max (and default)
        @limit = limit
        sort = "desc" unless (sort == "desc" || sort == "asc")
        @sort = sort
        @token = token
      end

      def get_transactions
        http_client.get(url, query, headers)
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token,
          'Content-Type' => 'application/xml'
        }
      end

      def query
        { 
        	:fromDate => from_date, 
        	:toDate => to_date,
        	:start => start,
        	:limit => limit,
        	:sort => sort
        }
      end

      def url
      	if account_id.nil?
      		::URI.join(
			  ::Finicity.config.base_url,
			  'v2/',
			  'customers/',
			  "#{customer_id}/",
			  'transactions'
			)
      	else
			::URI.join(
			  ::Finicity.config.base_url,
			  'v2/',
			  'customers/',
			  "#{customer_id}/",
			  'accounts/',
			  "#{account_id}/",
			  'transactions'
			)
		end
      end

    end
  end
end
