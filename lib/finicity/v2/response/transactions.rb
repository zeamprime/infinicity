module Finicity::V2
  module Response
    class Transaction
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :id
      attribute :amount, :type => ::Float
      attribute :accountId, :as => :account_id
      attribute :customerId, :as => :customer_id
      attribute :description
      attribute :memo
      attribute :postedDate, :type => ::Integer, :as => :posted_date
      attribute :status
    end

    class Transactions
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :transaction, :elements => true, :class => ::Finicity::V2::Response::Transaction, :as => :transactions
      attribute :found, :type => ::Integer
      attribute :displaying, :type => ::Integer
      attribute :moreAvailable, :type => Boolean
      # could also capture fromDate, toDate, and sort but those are input params so no point.
    end
  end
end
