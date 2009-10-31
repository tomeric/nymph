module Nymph
  class GemsController < ApplicationController
    layout 'nymph'

    before_filter :load_gem_configuration

    def index
      @gems = Nymph::Gem.find_loaded
    end
    
    def show
      @gem = Nymph::Gem.find_by_name(params[:id])
    
      render_404 unless @gem
    end
    
    private
    
    def render_404
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
    
    def load_gem_configuration
      ::Gem.configuration = ::Gem::ConfigFile.new([])
    end
  end
end