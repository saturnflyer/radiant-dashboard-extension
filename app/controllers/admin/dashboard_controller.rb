class Admin::DashboardController < ApplicationController
  def index
    @current_user_published_pages = current_user.pages.published.recently_updated.find(:all, :limit => 10)
    @current_user_draft_pages = current_user.pages.drafts.by_updated.find(:all, :limit => 10)
    
    @updated_pages = Page.recently_updated.find(:all, :limit => 10)
    @draft_pages = Page.drafts.by_updated.find(:all, :limit => 10)
    @reviewed_pages = Page.reviewed.by_updated.find(:all, :limit => 10)
    
    @updated_snippets = Snippet.recently_updated.find(:all, :limit => 10, :order => 'updated_at DESC') # default_order override
    @updated_layouts = Layout.recently_updated.find(:all, :limit => 10, :order => 'updated_at DESC') # default_order override
  end
end
