module LiquidFilters 

  def stylesheet(name)
		the_file = ThemeUpload.find_by_theme_file_file_name_and_theme_id(name, Thread.current[:current_theme])
		unless the_file.nil?
    	link = the_file.theme_file.url or "nicht gefunden"
			stylesheet = "<link href='" << link <<  "' rel='stylesheet' type='text/css' media='screen' />"
			return stylesheet
		else
			return ''
		end
  end

	def image(name)
		the_file = ThemeUpload.find_by_theme_file_file_name_and_theme_id(name, Thread.current[:current_theme])
		unless the_file.nil?
    	link = the_file.theme_file.url or "nicht gefunden"
			return link
		else
			return ''
		end
  end

	def javascript(name)
		the_file = ThemeUpload.find_by_theme_file_file_name_and_theme_id(name, Thread.current[:current_theme])
		unless the_file.nil?
    	link = the_file.theme_file.url or "nicht gefunden"
			javascript_file = "<script src='" << link <<  "'></script>"
			return javascript_file
		else
			return ''
		end
  end

	def item_content(name)
		page = Page.find(83)#Thread.current[:current_page])
		theme_item = ThemeItem.find_by_name_and_theme_id(name, Theme.find(page.theme_id))
		item = Item.find_by_theme_item_id_and_page_id_and_active(theme_item.id, page.id, true)
		return  ItemDataContent.find_by_locale_and_item_id(Thread.current[:current_locale].to_s, item.id).content rescue " "
	end
	
end