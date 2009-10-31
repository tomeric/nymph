class LoadedGemsController < ApplicationController
  def index
    @gems = Nymph::Gem.loaded
  end
end