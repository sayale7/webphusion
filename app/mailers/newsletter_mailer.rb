class NewsletterMailer < ActionMailer::Base
  def newsletter(recipient, page)
			@page = page
	    mail(:from => User.find(page.website_id).email,
	 				  # headers["Reply-to"] =  User.find(page.website_id).email,
					 :to => recipient.email,
	         :subject => page.name)
	 end
end
