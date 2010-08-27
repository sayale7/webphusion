Paperclip::Attachment.interpolations[:theme_id] = proc do |attachment, style|
  attachment.instance.theme_id # or whatever you've named your User's login/username/etc. attribute
end