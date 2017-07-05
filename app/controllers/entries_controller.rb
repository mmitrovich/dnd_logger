class EntriesController < ApplicationController

	before_action :get_log_book

  def index
    @entries = entry_filter
  	@entry = @log_book.entries.new
    load_tags
  end

  def edit
  	@entry = Entry.find(params[:id])
  end

  def create
    @entry = @log_book.entries.new(entry_params)
    if @entry.save
      add_tags(@entry)
      redirect_to entries_path(:log_book_id => @log_book.id)
    else
      @entries = @log_book.entries.sorted
      render 'index'
    end
  end

	def update
	  	@entry = Entry.find(params[:id])
	  	if @entry.update_attributes(entry_params)
        @entry.tags.clear
        add_tags(@entry)
        cleanup_tags
	  		redirect_to entries_path(:log_book_id => @log_book.id)
	  	else
	  		render 'edit'
	  	end
  	end

	def destroy
		@entry = Entry.find(params[:id])
		@entry.destroy
    cleanup_tags
		redirect_to entries_path(:log_book_id => @log_book.id)
	end



  private

  def entry_params
  	params.require(:entry).permit(:description)
  end

  def get_log_book
  	@log_book = LogBook.find(params[:log_book_id])
  end

  def add_tags (entry)
    regex = /([@#\$!])(\w+)|([@#\$!])"([^"]+)"/
    entry.description.scan(regex) do |match|
      token, text = match.compact
      type = get_type(token)
      tag = Tag.where(:tag_type => type, :tag_name => text).first_or_create
      entry.tags << tag
    end
  end

  def get_type(token)
    case token
      when '@' then 'characters'
      when '#' then 'locations'
      when '$' then 'money'
      when '!' then 'items'
    end
  end

  def cleanup_tags
    Tag.includes(:taggings).where(:taggings => { :tag_id => nil }).each do |t|
      t.destroy
    end
  end


  def entry_filter
    type = params[:type_filter]
    tag_name = params[:specific_tag]
    if type
      if tag_name
        @filter_type = "Entries for #{tag_name} (#{type})"
        @log_book.entries.includes(:tags).where(:tags => {:tag_type => type, :tag_name => tag_name}).order('entries.created_at DESC')
      else
        @filter_type = "#{type.capitalize}"
        @log_book.entries.includes(:tags).where(:tags => {:tag_type => type}).order('entries.created_at DESC')
      end
    else
        @filter_type = "All Entries"
        @log_book.entries.sorted
    end
  end

  def load_tags
    @char_tags = []
    @loc_tags = []
    @money_tags = []
    @item_tags = []
    Tag.includes(:entries).where(:entries => {:log_book_id => @log_book}).where("tag_type = 'characters'").each do |t|
      @char_tags << t.tag_name
    end
    Tag.includes(:entries).where(:entries => {:log_book_id => @log_book}).where("tag_type = 'locations'").each do |t|
      @loc_tags << t.tag_name
    end
    Tag.includes(:entries).where(:entries => {:log_book_id => @log_book}).where("tag_type = 'money'").each do |t|
      @money_tags << t.tag_name
    end
    Tag.includes(:entries).where(:entries => {:log_book_id => @log_book}).where("tag_type = 'items'").each do |t|
      @item_tags << t.tag_name
    end
  end
  
end
