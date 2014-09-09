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
      before do
        allow(subject).to receive(:write).with(:number, 100)
      end

      it 'sets number from file' do
        subject.update
        expect(subject.number).to eql 100
      end
    end

    context 'when cache (file) does not exist' do
      before(:each) do
        allow(File).to receive(:exists?).once.and_return(false)
        allow(File).to receive(:open).once.with(path, 'w')
      end

      it 'creates a new file' do
        expect(subject).to receive(:create_file).once
        subject.update
      end

      it 'resets number to 1' do
        subject.update
        expect(subject.number).to eql 1
      end
    end

  end

  describe '.reset' do

    let(:number) { 27 }

    before do
      allow(subject).to receive(:write).with(:number, 27)
    end

    it 'resets number to given Integer' do
      subject.reset number
      expect(subject.number).to eql 27
    end

  end

end
