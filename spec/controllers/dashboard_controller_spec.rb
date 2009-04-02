require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::DashboardController do
  dataset :users, :dashboard, :snippets
  
  before(:each) do
    @date_time = DateTime.strptime("12 October 2008", "%d %B %Y")
    Time.stub!(:now).and_return(@date_time.to_time)
    assigns[:updated_pages] = Page.recently_updated
    login_as :admin
  end
  
  describe "/index with GET" do
    before(:each) do
      get 'index'
    end
    it "should collect updated_pages" do
      assigns[:updated_pages].should == Page.recently_updated.find(:all, :limit => 10)
    end
    it "should find pages no earlier than 7 days ago" do
      assigns[:updated_pages].each do |page|
        page.updated_at.should >= @date_time.to_time - 7.days
      end
    end
    it "should limit the collected pages to 10" do
      assigns[:updated_pages].size.should <= 10
    end
    it "should collect updated_snippets" do
      assigns[:updated_snippets].should == Snippet.recently_updated
    end
  end
end
