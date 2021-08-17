require 'rails_helper'

RSpec.describe DailyPackageRetrieveWorker, type: :model do
  describe '#perform' do 
    it "reads link/file and processes it" do
      expect(subject).to receive(:process_web_file)
      subject.perform('spec/support/test_data_set.txt')
    end
  end

  describe '#process_web_file' do
    it 'processes file and calls enque_file_worker with correct args' do
      file = IO.read('spec/support/test_data_set.txt')
      expect(subject).to receive(:enque_file_worker).with("RODBC", "1.3-16")
      subject.process_web_file(file)
    end

    it 'processes file and calls enque_file_worker 5 times' do
      file = IO.read('spec/support/test_data_big_set.txt')
      expect(subject).to receive(:enque_file_worker).exactly(5).times
      subject.process_web_file(file)
    end
  end
end
