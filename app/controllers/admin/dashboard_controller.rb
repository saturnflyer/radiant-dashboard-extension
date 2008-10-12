class Admin::DashboardController < ApplicationController

  def index
    recent_range = Time.now - 7.days
    recent_conditions = {
      :conditions => ["updated_at > :updated_at", {:updated_at => recent_range}], 
      :limit =>10, 
      :order => 'updated_at DESC'}
    @updated_pages = Page.find(:all, recent_conditions)
    @updated_snippets = Snippet.find(:all, recent_conditions)
    @draft_pages = Page.find(:all, :conditions => {:status_id => Status['Draft'].id}, :limit => 10)
    @reviewed_pages = Page.find(:all, 
      :conditions => ["status_id = :status_id and updated_at > :updated_at",
        {:status_id => Status['Reviewed'].id, :updated_at => recent_range}], :limit => 10)
    @updated_layouts = Layout.find(:all, recent_conditions)
  end
end
