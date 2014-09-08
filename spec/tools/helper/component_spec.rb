require 'spec_helper'

describe Alephant::Harness::Tools::Helper::Component do

  subject { Alephant::Harness::Tools::Helper::Component.new base_path }

  let(:component) { 'test' }
  let(:base_path) { 'spec/fixtures' }


  before(:each) do
    allow_any_instance_of(Thor::Shell::Basic).to receive(:say).and_return(nil)
  end

  describe '.new' do
    it 'reads component ID' do
      expect(subject.id).to eql component
    end
  end

  describe '.change' do
    let(:new_component) { 'new_test' }
    let(:app_json) { JSON.parse File.read "#{base_path}/src/config/development/app.json" }

    it 'writes new component ID' do
      hash = app_json.tap do |h|
        h['configuration']['component_id'] = new_component
        h['configuration']['renderer_id'] = new_component
      end

      allow(subject).to receive(:write).once.with(hash).and_return(nil)
      subject.change new_component
      expect(subject).to have_received(:write).with(hash)
    end
  end

end
