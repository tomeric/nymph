module Nymph
  class GemsController < ApplicationController
    layout 'nymph'

    def index
      @gems = Nymph::Gem.find_loaded
    end
    
    def show
      @gem = Nymph::Gem.find_by_name(params[:id])
    end
    
    def feed
      case URI.parse(params[:feed])
      when URI::HTTP, URI::HTTPS
        render :text => open(params[:feed]).read
      else
        render :nothing => true 
      end
    end
  end
end