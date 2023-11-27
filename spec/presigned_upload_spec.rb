# frozen_string_literal: true

require "spec_helper"

RSpec.describe PresignedUpload do
  describe ".configure" do
    it "yields self to the block for configuration" do
      PresignedUpload.configure do |config|
        expect(config).to eq(PresignedUpload)
      end
    end
  end

  describe ".storage_config" do
    context "when storage config is not set" do
      it "returns an empty hash" do
        expect(PresignedUpload.storage_config).to eq({})
      end
    end

    context "when storage config is set" do
      before do
        PresignedUpload.configure { |config| config.storage_config = { bucket: "bucket_name" } }
      end

      it "returns the configured storage config" do
        expect(PresignedUpload.storage_config).to eq({ bucket: "bucket_name" })
      end
    end
  end

  describe ".storage" do
    it "can set and retrieve the storage type" do
      PresignedUpload.storage = :aws
      expect(PresignedUpload.storage).to eq(:aws)
    end
  end
end
