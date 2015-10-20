module Paperclip
  module Storage
    module Eagle
      SERVER = "http://st1.eaglecdn.com"
      STORAGE_SERVERS = ["http://v23.dultonmedia.com", "http://v24.dultonmedia.com"]

      def self.extended base
        base.instance_eval do
          unless @options[:url].include?(":st_server")
            @options[:url] = ":st_server/:account_code/logos/:hash.:extension"
          end
          @options[:restricted_characters] = /[&$+,\"\/:;=?@<>\[\]\{\}\|\\\^~%# ]/
        end
        
        Paperclip.interpolates(:st_server) do |attachment, style|
          SERVER
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
          STORAGE_SERVERS.each do |server|
            delete_request_url = path.scan(/#{SERVER}.*/).first.sub SERVER, server
            log("deleting #{delete_request_url}")
            
            `curl -XDELETE --max-time 3 #{delete_request_url}`
          end
        end
        
        @queued_for_delete = []
      end
    end
  end
  TempfileFactory::ILLEGAL_FILENAME_CHARACTERS = /[~\']/
end
