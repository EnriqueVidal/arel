module Arel
  class Insert < Compound
    attributes :relation, :record
    deriving :==

    def initialize(relation, record)
      @relation, @record = relation, record.bind(relation)
    end

    def to_sql(formatter = nil)
      [
        "INSERT",
        "INTO #{table_sql}",
        "(#{record.keys.collect(&:to_sql).join(', ')})",
        "VALUES (#{record.collect { |key, value| key.format(value) }.join(', ')})"
      ].join("\n")
    end
    
    def call
      engine.create(self)
    end
  end
end