# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DashboardExtension < Radiant::Extension
  version "1.0"
  description "Dashboard provides a way to view recent activity in Radiant."
  url "http://saturnflyer.com/"
  
  define_routes do |map|
    map.connect 'admin/dashboard/:action', :controller => 'admin/dashboard'
  end
  
  def activate
    admin.tabs.add "Dashboard", "/admin/dashboard", :before => "Pages", :visibility => [:all]
    Radiant::AdminUI.class_eval do
      attr_accessor :dashboard
    end
    admin.dashboard = load_default_dashboard_regions
  end
  
  def deactivate
    # admin.tabs.remove "Dashboard"
  end
  
  private
  
  def load_default_dashboard_regions
    returning OpenStruct.new do |dashboard|
      dashboard.index = Radiant::AdminUI::RegionSet.new do |index|
        index.main.concat %w{header updated_pages updated_snippets}
        index.extensions.concat %w{}
      end
    end
  end
  
end