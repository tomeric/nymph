module Nymph
  class Gem
    @@configuration = ::Gem.configuration.send(:hash).dup.freeze
    cattr_accessor :configuration
    
    attr_accessor :name, :current_version, :dependencies, :requirements
    
    def initialize(options = {})
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def self.sources
      configuration[:sources]
    end
    
    def self.loaded
      Hash[::Gem.loaded_specs].values.map do |gem|
        Gem.new(:name            => gem.name,
                :current_version => gem.version,
                :dependencies    => parse_dependencies(gem))
      end
    end
    
    def self.parse_dependencies(gem)
      []
    end
  end
end