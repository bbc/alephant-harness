require 'spec_helper'

describe Alephant::Harness::Tools::Helper::Component do

  subject { Alephant::Harness::Tools::Helper::Component.new base_path }

  let(:component) { 'test' }
  let(:base_path) { 'spec/fixtures' }

  before(:each) do
    allow_any_instance_of(Thor::Shell::Basic).to receive(:say)
  end

  describe '.new' do
    it 'reads component ID' do
      expect(subject.id).to eql component
    end
  end

  describe '.change' do
    let(:new_component) { 'new_test' }
    let(:app_json) { JSON.parse File.read app_json_path }
    let(:app_json_path) { "#{base_path}/src/config/development/app.json" }

    before do
      allow(File).to receive(:open).once.with(app_json_path, 'w').once
    end

    it 'writes new component ID' do
      hash = app_json.tap do |h|
        h['configuration']['component_id'] = new_component
        h['configuration']['renderer_id'] = new_component
      end

      expect(subject).to receive(:write).with(hash)
      subject.change new_component
    end
  end

end
