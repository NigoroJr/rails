class SkkdictEntriesController < ApplicationController
  before_filter :login_required, :except => [:index, :search]

  def index
    @skkdict_entries = SkkdictEntry.all.order("reading")
    p @skkdict_entries
  end

  def new
    @skkdict_entry = SkkdictEntry.new
  end

  def edit
    @skkdict_entry = SkkdictEntry.find(params[:id])
    # Convert delimiter "\0" to human-readable ";"
    @skkdict_entry.tags.gsub!("\0", ";")
  end

  def create
    @skkdict_entry = SkkdictEntry.new
    @skkdict_entry.reading = params[:skkdict_entry][:reading]
    @skkdict_entry.word = params[:skkdict_entry][:word]
    @skkdict_entry.posted_by = @logged_in_as.username
    tags = params[:skkdict_entry][:tags]
    @skkdict_entry.tags = replace_delimiter(tags)

    if @skkdict_entry.save
      redirect_to action: "index"
    else
      render "new"
    end
  end

  def update
    @skkdict_entry = SkkdictEntry.find(params[:id])
    @skkdict_entry.reading = params[:skkdict_entry][:reading]
    @skkdict_entry.word = params[:skkdict_entry][:word]
    @skkdict_entry.posted_by = @logged_in_as.username
    tags = params[:skkdict_entry][:tags]
    @skkdict_entry.tags = replace_delimiter(tags)

    if @skkdict_entry.save
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def destroy
    @skkdict_entry = SkkdictEntry.find(params[:id])
    @skkdict_entry.destroy

    render "index"
  end

  def search
    tags = params[:tags]

    # TODO: search by tags
    p 'FOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOBAAAAAAAAAAAAAAAAAARRRR'

    # Bypass application.html.erb
    render "output", :layout => false
  end

  private
  # Tags from the form is separated by ';' but use
  # '\0' when saving to database.
  def replace_delimiter(orig_tags)
    new_tags = orig_tags.gsub(";", "\0")
    return new_tags
  end
end