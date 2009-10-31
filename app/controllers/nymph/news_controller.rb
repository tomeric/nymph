module Nymph
  class NewsController < ApplicationController
    layout false

    def show
      @gem   = Nymph::Gem.find_by_name(params[:id])
      @feeds = @gem.rss_feeds 
    end
    
    def proxy
      case URI.parse(params[:feed])
      when URI::HTTP, URI::HTTPS
        render :text => open(params[:feed]).read
      else
        render :nothing => true 
      end
    end
  end
end