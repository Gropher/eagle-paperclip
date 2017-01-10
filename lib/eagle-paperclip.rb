require "eagle-paperclip/version"

require "paperclip/storage/eagle"

Paperclip.interpolates('account_code') do |attachment, style|
  attachment.instance.account.code.parameterize
end

Paperclip.interpolates('filename_1st_char') do |attachment, style|
  File.basename(attachment.original_filename, ".*".freeze)[0] || "empty"
end


Paperclip.interpolates('filename_2nd_char') do |attachment, style|
  File.basename(attachment.original_filename, ".*".freeze)[1] || "empty"
end
