module Nymph
  class Dependency
    attr_accessor :name, :requirements
    
    def initialize(options)
      options.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
    
    def self.parse(dependencies)
      dependencies.map do |dependency|
        Dependency.new(:name         => dependency.name,
                       :requirements => dependency.requirements_list)
      end
    end
  end
end