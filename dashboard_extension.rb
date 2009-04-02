# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DashboardExtension < Radiant::Extension
  version "1.0"
  description "Dashboard provides a way to view recent activity in Radiant and gives small extensions a place to grow."
  url "http://saturnflyer.com/"
  
  define_routes do |map|
    map.dashboard 'admin/dashboard/:action', :controller => 'admin/dashboard'
  end
  
  def activate
    admin.tabs.add "Dashboard", "/admin/dashboard", :before => "Pages", :visibility => [:all]
    Radiant::AdminUI.class_eval do
      attr_accessor :dashboard
    end
    admin.dashboard = load_default_dashboard_regions
    User.class_eval {
      has_many :created_pages, :foreign_key => :created_by_id, :class_name => 'Page' unless self.respond_to?(:created_pages)
      has_many :updated_pages, :foreign_key => :updated_by_id, :class_name => 'Page' unless self.respond_to?(:updated_pages)
      has_many :pages, :foreign_key => :created_by_id unless self.respond_to?(:pages)
    }
    Page.class_eval {
      named_scope :drafts, :conditions => ['status_id = ?',Status['Draft'].id]
      named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ]}}
      named_scope :reviewed, lambda{{:conditions => ["status_id = ?", Status['Reviewed'].id ]}}
    }
    Snippet.class_eval { named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ]}} }
    Layout.class_eval { named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ]}} }
  end
  
  def deactivate
    # admin.tabs.remove "Dashboard"
  end
  
  private
  
  def load_default_dashboard_regions
    returning OpenStruct.new do |dashboard|
      dashboard.index = Radiant::AdminUI::RegionSet.new do |index|
        index.main.concat %w{header current_user_draft_pages current_user_updated_pages draft_pages reviewed_pages updated_pages updated_snippets updated_layouts}
        index.current_user_draft_pages_bottom.concat %w{}
        index.current_user_updated_pages_bottom.concat %w{}
        index.extensions.concat %w{}
      end
    end
  end
  
end