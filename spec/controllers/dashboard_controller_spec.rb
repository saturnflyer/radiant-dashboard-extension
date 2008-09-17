require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::DashboardController do
  scenario :users, :dashboard, :snippets
  
  before(:each) do
    @date_time = DateTime.strptime("12 October 2008", "%d %B %Y")
    Time.stub!(:now).and_return(@date_time.to_time)
    @updated_pages = pages(:recent).children.find(
              :all,
              :limit=>10, 
              :conditions=>["updated_at > :updated_at", 
                {:updated_at => Time.now - 7.days}], 
              :order => 'updated_at DESC')
    Page.should_receive(:find).with(
      :all, {
        :limit=>10, 
        :conditions=>["updated_at > :updated_at", 
          {:updated_at => Time.now - 7.days}], 
        :order => 'updated_at DESC'}).and_return(@updated_pages)
    @snip1 = mock_model(Snippet, :updated_at => @date_time)
    @updated_snippets = [@snip1]
    Snippet.should_receive(:find).with(
      :all, {
        :limit=>10, 
        :conditions=>["updated_at > :updated_at", 
          {:updated_at => Time.now - 7.days}], 
        :order => 'updated_at DESC'}).and_return(@updated_snippets)
    
    login_as :admin
  end
  
  describe "/index with GET" do
    before(:each) do
      get 'index'
    end
    it "should collect updated_pages" do
      assigns[:updated_pages].should == @updated_pages
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
      assigns[:updated_snippets].should == @updated_snippets
    end
  end
end
