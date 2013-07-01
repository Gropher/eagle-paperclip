require "eagle-paperclip/version"

require "paperclip/storage/eagle"

Paperclip.interpolates('account_code') do |attachment, style|
  attachment.instance.account.code.parameterize
end
