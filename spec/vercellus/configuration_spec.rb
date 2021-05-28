# frozen_string_literal: true

RSpec.describe Vercellus::Configuration do
  let(:token) { ENV["VERCELLUS_TOKEN"] || "vercellus_test_token" }

  before do
    Vercellus.configure do |config|
      config.token = token
    end
  end

  context "with configuration block" do
    it "returns the correct token" do
      expect(Vercellus.configuration.token).to eq(token)
    end
  end

  context "without configuration block" do
    before { Vercellus.reset }

    it "raises a configuration error for token" do
      expect { Vercellus.configuration.token }.to raise_error(Vercellus::Errors::Configuration)
    end
  end

  context "#reset" do
    it "resets configured values" do
      expect(Vercellus.configuration.token).to eq(token)

      Vercellus.reset

      expect { Vercellus.configuration.token }.to raise_error(Vercellus::Errors::Configuration)
    end
  end
end
