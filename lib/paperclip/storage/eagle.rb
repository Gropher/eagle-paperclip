module Paperclip
  module Storage
    module Eagle
      def self.extended base
        base.instance_eval do
          unless @options[:url].include?(":st_server")
            @options[:url] = ":st_server/:account_code/logos/:hash.:extension"
          end
          @options[:restricted_characters] = /[&$+,\"\/:;=?@<>\[\]\{\}\|\\\^~%# ]/
        end
        
        Paperclip.interpolates(:st_server) do |attachment, style|
          attachment.options[:st_server]
        end unless Paperclip::Interpolations.respond_to? :st_server
      end

      def exists?(style_name = default_style)
        `curl --write-out %{http_code} --silent --output /dev/null '#{url(style_name)}'`
      end

      def flush_writes
        @queued_for_write.each do |style_name, file|
           `curl -T '#{file.path}' '#{url(style_name)}'`
        end
        after_flush_writes # allows attachment to clean up temp files
        @queued_for_write = {}
      end

      def flush_deletes
        for path in @queued_for_delete do
          log("deleting #{path}")
          `curl -XDELETE --max-time 3 #{path}`
        end
        
        @queued_for_delete = []
      end
    end
  end
  TempfileFactory::ILLEGAL_FILENAME_CHARACTERS = /[~\']/
end
