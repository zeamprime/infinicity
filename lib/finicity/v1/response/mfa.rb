module Finicity::V1
  module Response
    class Question
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :text
      attribute :choice, :elements => true, :as => :choices, :class => ::Finicity::V1::Response::Choice
      attribute :image
      attribute :imageChoice, :elements => true, :as => :image_choices, :class => ::Finicity::V1::Response::Choice
    end
    
    ##
    # imageChoice and choice elements both have some text/data as well as a "value" attribute.
    ##
    class Choice
      include ::Saxomattic
      
      attribute :data
      attribute :value, :attribute => true
    end

    class Mfa
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :questions, :elements => true, :class => ::Finicity::V1::Response::Question
    end
  end
end
