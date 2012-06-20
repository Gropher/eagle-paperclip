module Paperclip
  module Storage
    module Eagle
      SERVER = "http://st1.eaglecdn.com"

      def self.extended base
        base.instance_eval do
          @options.instance_variable_set("@url", "#{SERVER}/logos/:hash.:extension")
        end
      end

      def exists?(style_name = default_style)
        `curl --write-out %{http_code} --silent --output /dev/null #{url style_name}`
      end

      def flush_writes
        @queued_for_write.each do |style_name, file|
           `curl -T #{file.path} #{url style_name}`
        end
        after_flush_writes # allows attachment to clean up temp files
        @queued_for_write = {}
      end

      def flush_deletes
        @queued_for_delete = []
      end
    end
  end
end
