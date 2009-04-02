require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/dashboard/index" do
  dataset :dashboard
  before do
    template.stub!(:include_stylesheet).and_return(true)
    @updated_pages = pages(:recent).children
    assigns[:updated_pages] = @updated_pages
    render '/admin/dashboard/index'
  end
  
  it "should have a list of recent pages" do
    response.should have_tag('ul') do
      with_tag('li',/Taylor/)
      with_tag('li',/Polk/)
      with_tag('li',/Tyler/)
      with_tag('li',/Harrison/)
      with_tag('li',/Van Buren/)
      with_tag('li',/Jackson/)
      with_tag('li',/Quincy Adams/)
      with_tag('li',/Monroe/)
      with_tag('li',/Madison/)
      with_tag('li',/Jefferson/)
    end
  end
end
