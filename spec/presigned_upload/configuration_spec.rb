# frozen_string_literal: true

require "spec_helper"

RSpec.describe PresignedUpload::Configuration do
  let(:config) { described_class.new }

  context "with invalid storage type" do
    it "raises InvalidStorage error" do
      config.storage = :invalid_storage

      expect { config.configure! }.to raise_error(PresignedUpload::InvalidStorage, /Invalid storage/)
    end
  end

  describe "with aws" do
    require "support/storage/aws"

    before { config.storage = :aws }

    context "with valid configuration" do
      it "does not raise an error" do
        config.storage_config = { bucket: "my_bucket" }

        expect { config.configure! }.not_to raise_error
      end
    end

    context "with empty storage configuration" do
      it "raises InvalidStorageConfig error" do
        config.storage_config = {}

        expect do
          config.configure!
        end.to raise_error(PresignedUpload::InvalidStorageConfig, /Empty storage configuration/)
      end
    end

    context "with missing required config keys for AWS storage" do
      it "raises InvalidStorageConfig error" do
        config.storage_config = { intruder_key: "intruder_value" }

        expect do
          config.configure!
        end.to raise_error(PresignedUpload::InvalidStorageConfig, /Missing storage configuration/)
      end
    end
  end
end
