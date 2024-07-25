# frozen_string_literal: true

require "spec_helper"
require "presigned_upload/uploadable"

RSpec.describe PresignedUpload::Models do
  describe ".presigned_uploadable" do
    it "includes the Uploadable module" do
      expect(UploadLink).to receive(:include).with(PresignedUpload::Uploadable)
      UploadLink.presigned_uploadable
    end
  end

  describe ".presigned_uploadable_model" do
    let(:model_instance) do
      UploadLink.new(original_name: "example.txt", content_type: "text/plain", upload_status: "initial")
    end

    it "includes the Uploadable::Model module" do
      expect(UploadLink).to receive(:include).with(PresignedUpload::Uploadable::Model)
      UploadLink.presigned_uploadable_model
    end

    context "when store_dir is provided as a symbol" do
      before { UploadLink.presigned_uploadable_model(store_dir: :generate_store_dir) }

      it "sets store_dir based on the symbol" do
        expect(model_instance.store_dir).to eq("generated/store/dir")
      end
    end

    context "when store_dir is provided as a string" do
      before { UploadLink.presigned_uploadable_model(store_dir: "custom/string/dir") }

      it "sets store_dir to the provided string" do
        expect(model_instance.store_dir).to eq("custom/string/dir")
      end
    end

    context "when store_dir is provided as a Proc" do
      before { UploadLink.presigned_uploadable_model(store_dir: -> { "custom/proc/dir" }) }

      it "sets store_dir based on the Proc" do
        expect(model_instance.store_dir).to eq("custom/proc/dir")
      end
    end

    context "when store_dir is not provided" do
      before { UploadLink.presigned_uploadable_model }

      it "sets a default store_dir based on model attributes" do
        expect(model_instance.store_dir).to eq("uploads/upload_links/#{model_instance.id}")
      end
    end
  end
end
