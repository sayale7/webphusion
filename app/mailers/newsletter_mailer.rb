class NewsletterMailer < ActionMailer::Base
  def newsletter(recipient, page)
	    @recipient = recipient
	    @url  = "http://example.com/login"
			@page = page
	    mail(:from => User.find(page.website_id).email,
					 :to => recipient.email,
	         :subject => page.name)
	 end
end
