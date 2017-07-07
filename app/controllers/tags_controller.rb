class TagsController < ApplicationController

	before_action :get_logbook

	def index
		@tags = @log_book.tags.sorted.uniq
		@indexed = {}
		@tags.each do |tag|
			letter = tag.tag_name.slice(0,1).upcase.gsub(/\d/, "#")
			@indexed[letter] ||= []
			@indexed[letter] << tag
		end
	end

	

	private

	def get_logbook
		@log_book = LogBook.find(params[:log_book_id])
	end
end



