class Admin::DashboardController < ApplicationController

  def index
    recent_conditions = {
      :conditions => ["updated_at > :updated_at", {:updated_at => Time.now - 7.days}], 
      :limit =>10, 
      :order => 'updated_at DESC'}
    @updated_pages = Page.find(:all, recent_conditions)
    @updated_snippets = Snippet.find(:all, recent_conditions)
  end
end
