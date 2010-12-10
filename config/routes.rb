ActionController::Routing::Routes.draw do |map|
  map.connect 'chatters/lookup', :controller => 'chatters', :action => 'lookup'
  map.root :controller => "index"
end
