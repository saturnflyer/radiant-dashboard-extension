class Admin::DashboardController < ApplicationController

  def index
    @current_user_updated_pages = current_user.pages.recently_updated.find(:all, :limit => 10)
    @current_user_draft_pages = current_user.pages.drafts.find(:all, :limit => 10)
    
    @updated_pages = Page.recently_updated.find(:all, :limit => 10)
    @draft_pages = Page.drafts.find(:all, :limit => 10)
    @reviewed_pages = Page.reviewed.find(:all, :limit => 10)
    
    @updated_snippets = Snippet.recently_updated.find(:all, :limit => 10)
    @updated_layouts = Layout.recently_updated.find(:all, :limit => 10)
  end
end
