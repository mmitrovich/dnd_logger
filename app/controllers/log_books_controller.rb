class LogBooksController < ApplicationController

	before_action :get_all_books

  def index
  	@log_book = LogBook.new()
  end

  def edit
  	@log_book = LogBook.find(params[:id])
  end

  def create
  	@log_book = LogBook.new(log_book_params)
    	if @log_book.save
    		redirect_to root_path
  	else
  		render 'index'
  	end
  end

  def update
  	@log_book = LogBook.find(params[:id])
  	if @log_book.update_attributes(log_book_params)
  		redirect_to root_path
	else
		render 'edit'
	end
  end

  def destroy
  	@log_book = LogBook.find(params[:id])
  	@log_book.destroy
  	redirect_to root_path
  end

  private

  def log_book_params
  	params.require(:log_book).permit(:title)
  end

  def get_all_books
  	@log_books = LogBook.sorted
  end
end
