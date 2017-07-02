module EntriesHelper


	def print_with_tags(text)
		regex = {
			:single => /([@])([\w]+)/,
			:multi => /([@#*])"([^"]+)"/
		}
		new_string = text.gsub regex[:multi] do 
			"#{$1}#{link_to $2, root_path}"
		end
		new_string.gsub! regex[:single] do
			"#{$1}#{link_to $2, root_path}"
		end
		sanitize new_string
	end
end
