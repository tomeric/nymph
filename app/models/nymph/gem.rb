module Nymph
  class Gem
    attr_accessor :name,
                  :description,
                  :current_version,
                  :dependencies,
                  :homepage,
                  :requirements
                  :rss_feeds
    
    class << self
      def find_loaded
        Hash[::Gem.loaded_specs].values.map do |gem|
          parse_gem(gem)
        end
      end
      
      def find_by_name(name)
        dependency = ::Gem::Dependency.new(name, "> 0")
        results    = ::Gem::SpecFetcher.fetcher.find_matching(dependency)
        
        if results.present?
          latest = results.first.first
          name   = "#{latest[0]}-#{latest[1].version}"
          source = URI.parse(results.first.last)
          remote = ::Gem::SpecFetcher.fetcher.fetch_spec([name], source)
          
          parse_gem(remote) if remote.present?
        end
      end
    
      def parse_gem(gem)
        Gem.new(:name            => gem.name,
                :description     => gem.description,
                :current_version => gem.respond_to?(:version) ? gem.version : nil,
                :homepage        => gem.respond_to?(:homepage) ? gem.homepage : nil,
                :dependencies    => Nymph::Dependency.parse(gem.dependencies))      
      end
    end
    
    def initialize(options = {})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def to_json
      "{ name: '#{name}', current_version: '#{current_version}', latest_version: '#{latest.try(:current_version)}'}"
    end
    
    def loaded
      Gem.find_loaded.detect { |gem| gem.name == name }
    end
    
    def outdated?
      loaded && loaded.current_version != latest.current_version
    end
    
    def rss_feeds
      return [] unless homepage
      
      doc = ::Nokogiri::HTML(open(homepage))
      feeds = []
      
      doc.css('link[@type="application/atom+xml"], link[@type="application/rss+xml"]').each do |feed|
        feeds << { :title => feed["title"], :url => feed["href"] }
      end
      
      feeds
    end
    
    def latest
      dependency = ::Gem::Dependency.new(name, ">= #{current_version}")
      remotes    = ::Gem::SpecFetcher.fetcher.fetch(dependency)
      
      Gem.parse_gem(remotes.first.first) if remotes.present?
    end
  end
end