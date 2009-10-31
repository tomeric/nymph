module Nymph
  class GemsController < ApplicationController
    def index
      @gems = Nymph::Gem.find_loaded
    end
    
    def show
      @gem = Nymph::Gem.find_by_name(params[:id])
    end
  end
end