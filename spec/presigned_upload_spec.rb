# frozen_string_literal: true

require "spec_helper"

RSpec.describe PresignedUpload do
  describe ".configure" do
    before do
      allow_any_instance_of(PresignedUpload::Configuration).to receive(:configure!).and_return(nil)
    end

    it "configures the gem with the provided block" do
      PresignedUpload.configure do |config|
        config.storage = :aws
        config.storage_options = { bucket: "my_bucket" }
      end

      configuration = PresignedUpload.configuration
      expect(configuration.storage).to eq(:aws)
      expect(configuration.storage_options).to eq(bucket: "my_bucket")
    end

    it "calls configure! on the configuration object" do
      PresignedUpload.configure { |config| }

      expect(PresignedUpload.configuration).to have_received(:configure!).once
    end
  end
end
