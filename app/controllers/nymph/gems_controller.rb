module Nymph
  class GemsController < ApplicationController
    def index
      @gems = Nymph::Gem.loaded
    end
  end
end