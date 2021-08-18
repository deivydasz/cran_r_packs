require 'rails_helper'

RSpec.describe SinglePackageRetrieveWorker, type: :model do
  describe '#perform' do 


    it "downloads and writes package and its author and maintainer" do
      test_file_path = 'spec/support/trust_0.1-8.tar.gz'
      allow(URI).to receive(:open).and_return(File.open(test_file_path))
      subject.perform('trust', '0.1-8')
      email = 'charlie@stat.umn.edu'
      name = 'Charles J. Geyer'
      expect(Package.where(name: 'trust', Version: '0.1-8').count).to eql 1
      expect(Author.where(name: name, email: email).count).to eql 1
      expect(Maintainer.where(name: name, email: email).count).to eql 1
    end
  end
end
