class EntriesController < ApplicationController

	before_action :get_log_book

  def index
  	@entries = @log_book.entries.sorted
  	@entry = @log_book.entries.new
  end

  def edit
  	@entry = Entry.find(params[:id])
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

	def update
	  	@entry = Entry.find(params[:id])
	  	if @entry.update_attributes(entry_params)
	  		redirect_to entries_path(:log_book_id => @log_book.id)
	  	else
	  		render 'edit'
	  	end
  	end

	def destroy
		@entry = Entry.find(params[:id])
		@entry.destroy
		redirect_to entries_path(:log_book_id => @log_book.id)
	end

  private

  def entry_params
  	params.require(:entry).permit(:description)
  end

  def get_log_book
  	@log_book = LogBook.find(params[:log_book_id])
  end
end
