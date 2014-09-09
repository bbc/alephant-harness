require 'spec_helper'

describe Alephant::Harness::Tools::Helper::Validation do

  subject { Alephant::Harness::Tools::Helper::Validation }

  let(:base_path) { "#{Dir.pwd}/spec/fixtures" }
  let(:component) { 'test' }
  let(:invalid_base_path) { "#{Dir.pwd}/invalid/spec/fixtures" }
  let(:invalid_component) { 'invalid_test' }

  context 'when given valid paths' do
    it 'finds given base directory' do
      expect(subject.base_exist? base_path).to be
    end

    it 'finds component within base' do
      expect(subject.component_exist? component, base_path).to be
    end

    it 'finds responsive.json fixture within component' do
      expect(subject.fixture_exist? component, base_path).to be
    end

    context 'when using custom .json' do
      it 'finds specified file' do
        custom_path = "#{base_path}/src/components/#{component}/fixtures/responsive.json"
        expect(subject.json_exist? custom_path).to be
      end
    end
  end

  context 'when given invalid paths' do
    it 'does not find base directory' do
      expect(subject.base_exist? invalid_base_path).to_not be
    end

    it 'does not find component within base' do
      expect(subject.component_exist? invalid_component, base_path).to_not be
    end

    it 'does not find responsive.json within invalid component' do
      expect(subject.fixture_exist? invalid_component, base_path).to_not be
    end
  end

end
