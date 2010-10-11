ActionController::Routing::Routes.draw do |map|
  map.dashboard 'admin/dashboard/:action', :controller => 'admin/dashboard'
end