require "spec_helper"

RSpec.describe Rack::App::SeQueL do
  it "has a version number" do
    expect(Rack::App::SeQueL::VERSION).not_to be nil
  end

  describe '.open_connection' do
    subject(:when_connection_opened) { described_class.open_connection }

    after { ENV.delete("DATABASE_URL") }

    context "when no env configurated" do
      before { ENV.delete("DATABASE_URL") }

      it { expect{ when_connection_opened }.to raise_error(KeyError) }
    end

    context "when database url configurated in the env" do
      before { ENV["DATABASE_URL"] = "mock://postgresql" }

      it { is_expected.to be_a Sequel::Database }
    end

  end
end
