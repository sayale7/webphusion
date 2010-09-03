class Subdomain  
	def self.matches?(request)  
		if request.subdomain.present?
			if request.subdomains.first.to_s.eql?('www')
				false
			elsif request.subdomains.first.to_s.length == 2 and request.subdomains.size == 1
				false
			else
				true
			end
		end
		#request.subdomain.present? && !(request.subdomain == 'www'  or request.subdomains.first.to_s.length == 2)
	end
end