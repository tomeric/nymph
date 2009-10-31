module Nymph
  class Gem
    attr_accessor :name,
                  :description,
                  :current_version,
                  :dependencies,
                  :requirements
    
    class << self
      def find_loaded
        Hash[::Gem.loaded_specs].values.map do |gem|
          parse_gem(gem)
        end
      end
      
      def find_by_name(name)
        dependency = ::Gem::Dependency.new(name, ">= 0")
        remotes    = ::Gem::SpecFetcher.fetcher.fetch(dependency)
        
        parse_gem(remotes.first.first) if remotes.present?
      end
    
      def parse_gem(gem)
        Gem.new(:name            => gem.name,
                :description     => gem.description,
                :current_version => gem.respond_to?(:version) ? gem.version : nil,
                :dependencies    => Nymph::Dependency.parse(gem.dependencies))      
      end
    end
    
    def initialize(options = {})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def loaded
      
    end
    
    def latest
      dependency = ::Gem::Dependency.new(name, ">= #{current_version}")
      remotes    = ::Gem::SpecFetcher.fetcher.fetch(dependency)
      
      Gem.parse_gem(remotes.first.first) if remotes.present?
    end
  end
end