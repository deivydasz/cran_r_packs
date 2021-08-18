require 'rails_helper'

RSpec.describe SinglePackageRetrieveWorker do
  describe '#perform' do 
    let(:package_name) { 'trust'}
    let(:version) { '0.1-8' }
    let(:email) { 'charlie@stat.umn.edu' }
    let(:persons_name) { 'Charles J. Geyer' }
    let(:test_file_path) { 'spec/support/trust_0.1-8.tar.gz' }

    subject { described_class.new.perform(package_name, version) }
    before { allow(URI).to receive(:open).and_return(File.open(test_file_path)) }

    it 'creates package' do
      expect { subject }.to change {
        Package.where(name: package_name, version: version).count
      }.from(0).to(1)
    end

    it 'creates author' do
      expect { subject }.to change {
        Author.where(name: persons_name, email: email).count
      }.from(0).to(1)
    end

    it 'creates maintainer' do
      expect { subject }.to change {
        Maintainer.where(name: persons_name, email: email).count
      }.from(0).to(1)
    end
  end
end
