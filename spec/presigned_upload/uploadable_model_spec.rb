# frozen_string_literal: true

require "spec_helper"
require "presigned_upload/uploadable"
require "support/storage/mock_aws"

RSpec.describe PresignedUpload::Uploadable::Model do
  let(:model_instance) { UploadLink.new }

  before(:all) do
    PresignedUpload.configure do |config|
      config.storage = :aws
      config.storage_options = { bucket: "my_bucket" }
    end

    UploadLink.presigned_uploadable_model
  end

  describe "#url" do
    context "when upload status is initial" do
      it "returns nil" do
        expect(model_instance.url).to be_nil
      end
    end

    context "when upload status is completed" do
      it "returns the presigned URL for accessing the stored file" do
        allow(model_instance).to receive(:completed?).and_return(true)
        allow(model_instance).to receive(:presigned_url).and_return("presigned_url")

        expect(model_instance.url).to eq("presigned_url")
      end
    end
  end

  describe "#upload_url" do
    context "when store path is blank" do
      it "returns nil" do
        model_instance.store_path = nil

        expect(model_instance.upload_url).to be_nil
      end
    end

    context "when upload status is completed" do
      it "returns nil" do
        model_instance.upload_status = "completed"

        expect(model_instance.upload_url).to be_nil
      end
    end

    context "when store path is present and upload status is not completed" do
      it "returns the presigned URL for uploading the file" do
        allow(model_instance).to receive(:store_path).and_return("store_path")
        allow(model_instance).to receive(:completed?).and_return(false)
        allow(model_instance).to receive(:presigned_url).and_return("presigned_url")

        expect(model_instance.upload_url).to eq("presigned_url")
      end
    end
  end

  describe "#delete_stored_file" do
    it "calls delete_file method with the correct store path" do
      allow(model_instance).to receive(:delete_file)

      model_instance.delete_stored_file

      expect(model_instance).to have_received(:delete_file).with(model_instance.store_path)
    end
  end
end
