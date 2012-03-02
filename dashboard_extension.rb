require File.expand_path("../lib/radiant-dashboard-extension/version", __FILE__)
require_dependency 'application_controller'
class DashboardExtension < Radiant::Extension
  version RadiantDashboardExtension::VERSION
  description "Dashboard provides a way to view recent activity in Radiant and gives small extensions a place to grow."
  url "http://saturnflyer.com/"

  def activate
    admin.nav.unshift(Radiant::AdminUI::NavTab.new('&#10025;'))
    tab "&#10025;" do
      add_item 'Activity', "/admin/dashboard"
    end
    Radiant::AdminUI.class_eval do
      attr_accessor :dashboard
    end
    admin.dashboard = load_default_dashboard_regions
    User.class_eval {
      has_many :pages, :foreign_key => :created_by_id unless self.respond_to?(:pages)
    }
    Page.class_eval {
      named_scope :drafts, :conditions => ['status_id = ?',Status['Draft'].id]
      named_scope :reviewed, :conditions => ["status_id = ?", Status['Reviewed'].id ]
      named_scope :published, :conditions => ["status_id = ?", Status['Published'].id ]
      named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ], :order => 'updated_at DESC'}}
      named_scope :by_updated, :order => 'updated_at DESC'
    }
    Snippet.class_eval {
      named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ], :order => 'updated_at DESC, name'}}
    }
    Layout.class_eval {
      named_scope :recently_updated, lambda{{:conditions => ['updated_at > ?', 1.week.ago ], :order => 'updated_at DESC'}}
    }
    Admin::WelcomeController.class_eval {
      before_filter :go_to_dashboard, :only => [:index]
      def go_to_dashboard
        redirect_to dashboard_path
      end
    }
  end

  def deactivate
  end

  private

  def load_default_dashboard_regions
    OpenStruct.new.tap do |dashboard|
      dashboard.index = Radiant::AdminUI::RegionSet.new do |index|
        index.info.concat %w{user}
        index.user_action_list.concat %w{standard_links}
        index.main.concat %w{current_user_draft_pages current_user_published_pages draft_pages reviewed_pages updated_pages updated_snippets updated_layouts}
        index.current_user_draft_pages_top.concat %w{}
        index.current_user_draft_pages_bottom.concat %w{}
        index.current_user_published_pages_top.concat %w{}
        index.current_user_published_pages_bottom.concat %w{}
        index.extensions.concat %w{}
      end
    end
  end

end