require 'spec_helper'

describe Alephant::Harness::Tools::Helper::Sequence do

  subject { Alephant::Harness::Tools::Helper::Sequence.new component }

  let(:component) { 'test' }
  let(:path) { 'spec/fixtures/tmp/renderer_sequence.yml' }

  before(:each) do
    allow(subject).to receive(:path).and_return(path)
  end

  describe '.new' do

    context 'when cache (file) does exist' do

      it 'sets number from file' do
        allow(subject).to receive(:write).once.with(:number, 100).and_return(nil)
        subject.update
        expect(subject.number).to eql 100
      end

    end

    context 'when cache (file) does not exist' do

      before(:each) do
        allow(subject).to receive(:exists?).once.and_return(false)
      end

      it 'creates a new file' do
        allow(subject).to receive(:create_file).once.and_return(nil)
        subject.update
        expect(subject).to have_received(:create_file).once
      end

      it 'resets number to 1' do
        allow(File).to receive(:open).with(path, 'w').and_return(nil)
        subject.update
        expect(subject.number).to eql 1
      end
    end
  end

  describe '.reset' do

    let(:number) { 27 }

    it 'sets number to given Integer' do
      allow(subject).to receive(:write).once.with(:number, 100).and_return(nil)
      subject.update
      expect(subject.number).to eql 100
      allow(subject).to receive(:write).once.with(:number, 27).and_return(nil)
      subject.reset number
      expect(subject.number).to eql 27
    end

  end

end
