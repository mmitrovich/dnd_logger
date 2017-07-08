module EntriesHelper


	def print_with_tags(text)
		regex = {
			:single => /([\^~@#*\$!])([\w]+)/,
			:multi => /([\^~@#*\$!])"([^"]+)"/
		}
		new_string = text.gsub regex[:multi] do 
			"#{$1}#{link_to $2, entries_path(:type_filter => get_tag_type($1), :specific_tag => $2, :log_book_id => @log_book.id)}"
		end
		new_string.gsub! regex[:single] do
			"#{$1}#{link_to $2, entries_path(:type_filter => get_tag_type($1), :specific_tag => $2, :log_book_id => @log_book.id)}"
		end
		sanitize new_string
	end


	def get_tag_type(token)
		case token
	      when '@' then 'characters'
	      when '#' then 'locations'	
	      when '$' then 'money'	
	      when '!' then 'items'
	      when '~' then 'rules'
	      when '^' then 'orgs'
	      when '*' then 'plots'
	    end
	end
end
