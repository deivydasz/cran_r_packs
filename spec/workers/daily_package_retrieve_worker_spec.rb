require 'rails_helper'

RSpec.describe DailyPackageRetrieveWorker, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe '#perform' do 
    it "returns 1" do
      expect(subject.perform).to eql(1)
    end
  end
end
