module Arel
  class Expression < Attribute
    attributes :attribute, :alias, :ancestor
    deriving :==
    delegate :relation, :to => :attribute
    alias_method :name, :alias
    
    def initialize(attribute, aliaz = nil, ancestor = nil)
      @attribute, @alias, @ancestor = attribute, aliaz, ancestor
    end
    
    def aggregation?
      true
    end
    
    module Transformations
      def as(aliaz)
        self.class.new(attribute, aliaz, self)
      end
      
      def bind(new_relation)
        new_relation == relation ? self : self.class.new(attribute.bind(new_relation), @alias, self)
      end
          
      def to_attribute
        Attribute.new(relation, @alias, :ancestor => self)
      end
    end
    include Transformations
  end
  
  class Count   < Expression; end
  class Sum     < Expression; end
  class Maximum < Expression; end
  class Minimum < Expression; end
  class Average < Expression; end
end