class DashboardDataset < Dataset::Base
  uses :home_page, :users
  
  def load
    create_page "Recent" do
      create_page "Taylor",       :created_by_id => users(:admin), :created_at => DateTime.parse('1849-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-07 12:12:23')
      create_page "Polk",         :created_by_id => users(:admin), :created_at => DateTime.parse('1845-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-07 12:12:22')
      create_page "Tyler",        :created_by_id => users(:admin), :created_at => DateTime.parse('1841-04-04 12:12:12'), :updated_at => DateTime.parse('2008-10-07 12:12:21')
      create_page "Harrison",     :created_by_id => users(:admin), :created_at => DateTime.parse('1841-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-06 12:12:20')
      create_page "Van Buren",    :created_by_id => users(:admin), :created_at => DateTime.parse('1837-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-06 12:12:19')
      create_page "Jackson",      :created_by_id => users(:admin), :created_at => DateTime.parse('1829-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-06 12:12:18')
      create_page "Quincy Adams", :created_by_id => users(:admin), :created_at => DateTime.parse('1825-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-05 12:12:17')
      create_page "Monroe",       :created_by_id => users(:admin), :created_at => DateTime.parse('1817-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-05 12:12:16')
      create_page "Madison",      :created_by_id => users(:admin), :created_at => DateTime.parse('1809-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-05 12:12:15')
      create_page "Jefferson",    :created_by_id => users(:admin), :created_at => DateTime.parse('1801-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-04 12:12:14')
      create_page "Adams",        :created_by_id => users(:admin), :created_at => DateTime.parse('1797-03-04 12:12:12'), :updated_at => DateTime.parse('2008-10-01 12:12:13')
      create_page "Washington",   :created_by_id => users(:admin), :created_at => DateTime.parse('1789-04-30 12:12:12'), :updated_at => DateTime.parse('2008-10-01 12:12:12')
    end
  end
  
end