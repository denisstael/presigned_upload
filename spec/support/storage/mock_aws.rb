# frozen_string_literal: true

module Aws
  module S3
    class Resource
      def bucket(_bucket_name)
        Bucket.new
      end

      class Bucket
        def object(_key)
          Object.new
        end
      end

      class Object
        def presigned_url(_method, _options = {})
          "presigned/url"
        end

        def upload_file(_key)
          "Object uploaded"
        end

        def delete
          "Object deleted"
        end
      end
    end
  end
end
