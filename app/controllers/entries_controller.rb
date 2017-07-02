class EntriesController < ApplicationController

	before_action :get_log_book

  def index
  	@entries = @log_book.entries.sorted
  	@entry = @log_book.entries.new
  end

  def edit
  end

  def create
  	@entry = @log_book.entries.new(entry_params)
	if @entry.save
		redirect_to entries_path(:log_book_id => @log_book.id)
  	else
  		@entries = @log_book.entries.sorted
  		render 'index'
  	end
  end

  private

  def entry_params
  	params.require(:entry).permit(:description)
  end

  def get_log_book
  	@log_book = LogBook.find(params[:log_book_id])
  end
end
