require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe Insert do
    before do
      @relation = Array.new([
        [1, 'duck' ],
        [2, 'duck' ],
        [3, 'goose']
      ], [:id, :name])
    end

    describe '#call' do
      it "manufactures an array of hashes of attributes to values" do
        @relation                                                         \
          .insert(@relation[:id] => 4, @relation[:name] => 'guinea fowl') \
        .let do |relation|
          relation.call.should == [
            Row.new(relation, [1, 'duck']),
            Row.new(relation, [2, 'duck']),
            Row.new(relation, [3, 'goose']),
            Row.new(relation, [4, 'guinea fowl'])
          ]
        end
      end
    end
  end
end
