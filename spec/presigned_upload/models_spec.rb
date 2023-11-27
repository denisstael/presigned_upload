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
    let(:model_instance) { UploadLink.new }

    it "includes the Uploadable::Model module" do
      expect(UploadLink).to receive(:include).with(PresignedUpload::Uploadable::Model)
      UploadLink.presigned_uploadable_model
    end

    context "when store_path is provided as a symbol" do
      before { UploadLink.presigned_uploadable_model(store_path: :generate_store_path) }

      xit "sets store_path based on the symbol" do
        model_instance.run_callbacks(:create)

        expect(model_instance.store_path).to eq("generated_store_path")
      end
    end

    context "when store_path is provided as a string" do
      before { UploadLink.presigned_uploadable_model(store_path: "custom_path") }

      xit "sets store_path to the provided string" do
        model_instance.run_callbacks(:create)
        expect(model_instance.store_path).to eq("custom_path")
      end
    end

    context "when store_path is provided as a Proc" do
      before { UploadLink.presigned_uploadable_model(store_path: -> { "custom_path_from_proc" }) }

      xit "sets store_path based on the Proc" do
        model_instance.run_callbacks(:create)
        expect(model_instance.store_path).to eq("custom_path_from_proc")
      end
    end

    context "when store_path is not provided" do
      before { UploadLink.presigned_uploadable_model }

      xit "sets a default store_path based on model attributes" do
        model_instance.original_name = "example.txt"
        model_instance.run_callbacks(:create)
        expect(model_instance.store_path).to eq("uploads/test_models/example.txt")
      end
    end
  end
end
