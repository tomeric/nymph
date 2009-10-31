ActionController::Routing::Routes.draw do |map|
  map.map "/nymph/gems/outdated.json", :controller => 'nymph/gems', :action => 'outdated', :format => 'json'
  map.namespace(:nymph) do |nymph|
    nymph.root :controller => 'gems'
    nymph.resources :gems, :member => { :outdated => :get }
    nymph.resources :news, :collection => { :proxy => :get }
  end
end