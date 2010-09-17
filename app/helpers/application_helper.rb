module ApplicationHelper
	
	def only_editable(array)
		new_array = Array.new
		array.each do |entry|
			if entry.theme_file_content_type.eql?('text/css') or entry.theme_file_content_type.include?('application/javascriptapplication/x-javascript')
				new_array.push(entry)
			end
		end
		return new_array
	end
	
	def get_available_locales
		return ["de", "en"]# - item.item_data_contents.collect { |content| content.locale.to_s }
	end
	
	def available_theme_items(page)
		theme_items = Array.new
		page.items_by_theme.each do |item|
			theme_item = ThemeItem.find(item.theme_item_id)
			unless theme_item.nil?
				theme_items.push(theme_item)
			end
		end
		return theme_items
	end
	
	def get_content_id(page)
		Theme.find(page.theme_id).theme_items.each do |theme_item|
			Item.find_or_create_by_theme_item_id_and_page_id(theme_item.id, page.id)
		end
		if page.items.empty?
			return nil
		else
			page.items.first.item_data_contents.first.id
		end
	end
	
	def theme_item_kinds
		%w[Text Bilder Einzeiler]
	end
	
	def clippy(text, bgcolor='#fff')
	  html = <<-EOF
	    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
	            width="110"
	            height="14"
	            id="clippy" >
	    <param name="movie" value="/assets/clippy.swf"/>
	    <param name="allowScriptAccess" value="always" />
	    <param name="quality" value="high" />
	    <param name="scale" value="noscale" />
	    <param NAME="FlashVars" value="text=#{text}">
	    <param name="bgcolor" value="#{bgcolor}">
	    <embed src="/assets/clippy.swf"
	           width="110"
	           height="14"
	           name="clippy"
	           quality="high"
	           allowScriptAccess="always"
	           type="application/x-shockwave-flash"
	           pluginspage="http://www.macromedia.com/go/getflashplayer"
	           FlashVars="text=#{text}"
	           bgcolor="#{bgcolor}"
	    />
	    </object>
	  EOF
	end
	
	def get_long_version(locale)
		if locale.to_s.eql?('de')
			t 'language.de'
		elsif locale.to_s.eql?('en')
			t 'language.en'
		end
	end
	
	def has_children(page)
		if Page.find_all_by_parent_id(page.id).empty?
			false
		else
			true
		end
	end
	
end
