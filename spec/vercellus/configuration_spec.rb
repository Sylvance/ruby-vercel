# frozen_string_literal: true
require_relative '../spec_helper'

RSpec.describe Vercellus::Configuration do
  before do
    Vercellus.configure do |config|
      config.token = ENV['VERCELLUS_TOKEN']
    end
  end

  context 'with configuration block' do
    it 'returns the correct token' do
      expect(Vercellus.configuration.token).to eq(ENV['VERCELLUS_TOKEN'])
    end
  end

  context 'without configuration block' do
    before do
      Vercellus.reset
    end

    it 'raises a configuration error for token' do
      expect { Vercellus.configuration.token }.to raise_error(Vercellus::Errors::Configuration)
    end
  end

  context '#reset' do
    it 'resets configured values' do
      expect(Vercellus.configuration.token).to eq(ENV['VERCELLUS_TOKEN'])

      Vercellus.reset

      expect { Vercellus.configuration.token }.to raise_error(Vercellus::Errors::Configuration)
    end
  end
end
