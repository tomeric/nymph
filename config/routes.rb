ActionController::Routing::Routes.draw do |map|
  map.namespace(:nymph) do |nymph|
    nymph.resources :gems, :collection => { :feed => :get }
  end
end
