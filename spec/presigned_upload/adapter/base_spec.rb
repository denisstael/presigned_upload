# frozen_string_literal: true

require "spec_helper"

RSpec.describe PresignedUpload::Adapter::Base do
  let(:storage_options) { { bucket: "my_bucket" } }

  describe "#initialize" do
    it "initializes with the storage options from PresignedUpload.configuration" do
      allow(PresignedUpload.configuration).to receive(:storage_options).and_return(storage_options)

      adapter = described_class.new

      expect(adapter.instance_variable_get(:@storage_options)).to eq(storage_options)
    end
  end
end
