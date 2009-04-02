require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  before do
    @date_time = DateTime.strptime("12 October 2008", "%d %B %Y")
    Time.stub!(:now).and_return(@date_time.to_time)
  end
  describe "recently_updated" do
    it 'should return pages updated less than one week ago' do
      Page.recently_updated.each do |page|
        page.updated_at.should > @date_time - 1.week
      end
    end
  end
end