require "eagle-paperclip/version"

require "paperclip/storage/eagle"

Paperclip.interpolates('account_code') do |attachment, style|
  attachment.instance.account.code.parameterize
end

Paperclip.interpolates('filename_1st_char') do |attachment, style|
  attachment.hash_key(style)[0]
end


Paperclip.interpolates('filename_2nd_char') do |attachment, style|
  attachment.hash_key(style)[1]
end
