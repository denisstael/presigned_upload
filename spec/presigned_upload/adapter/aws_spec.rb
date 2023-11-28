# frozen_string_literal: true

require "spec_helper"
require "presigned_upload/adapter/aws"
require "support/storage/mock_aws"

RSpec.describe PresignedUpload::Adapter::Aws do
  let(:aws_adapter) { described_class.new }

  before(:all) do
    PresignedUpload.configure do |config|
      config.storage = :aws
      config.storage_options = { bucket: "my_bucket" }
    end
  end

  describe "#presigned_url" do
    let(:dummy_presigned_url) { "https://s3.amazonaws.com/test_bucket/test_key?AWSAccessKeyId=dummy&Signature=dummy&Expires=dummy" }

    it "generates a presigned URL for the specified key, method, and expiration time" do
      allow(aws_adapter).to receive(:presigned_url).and_return(dummy_presigned_url)

      expect(aws_adapter.presigned_url("test_key", :put, 3600)).to eq(dummy_presigned_url)
    end
  end

  describe "#upload_file" do
    it "uploads the specified file to the storage with the given key" do
      expect { aws_adapter.upload_file("/path/to/local/file.txt", "test_key") }.not_to raise_error
    end
  end

  describe "#delete_file" do
    it "deletes the file with the specified key from the storage" do
      expect { aws_adapter.delete_file("test_key") }.not_to raise_error
    end
  end
end
