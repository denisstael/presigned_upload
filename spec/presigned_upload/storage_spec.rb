# frozen_string_literal: true

require "spec_helper"
require "presigned_upload/storage"
require "support/storage/mock_aws"

RSpec.describe PresignedUpload::Storage do
  let(:dummy_class) do
    Class.new { include PresignedUpload::Storage }
  end
  let(:model_instance) { dummy_class.new }

  before(:all) do
    PresignedUpload.configure do |config|
      config.storage = :aws
      config.storage_options = { bucket: "my_bucket" }
    end
  end

  describe "#presigned_url" do
    let(:method) { :get }
    let(:expires_in) { 3600 }
    let(:key) { "file.txt" }

    it "calls presigned_url on the adapter" do
      expect(model_instance.send(:adapter)).to receive(:presigned_url).with(key, method, expires_in).once

      model_instance.presigned_url(key, method, expires_in)
    end
  end

  describe "#delete_file" do
    let(:key) { "file.txt" }

    it "calls delete_file on the adapter" do
      expect(model_instance.send(:adapter)).to receive(:delete_file).with(key).once

      model_instance.delete_file(key)
    end
  end
end
