module Kontena::Stacks
  class StackData

    attr_reader :loader

    # @param data [Hash]
    # @param loader [StackFileLoader,NilClass]
    def initialize(data, loader = nil)
      @data = data
      @loader = loader
    end

    # Compares StackData with another instance of StackData
    # @return [Boolean]
    def ==(another)
      return false unless another.class == self.class
      %i(stack_name version parent variables service_names).all? do |field|
        send(field) == another.send(field)
      end
    end

    # @return [String]
    def name
      @data['name']
    end

    # @return [String]
    def stack_name
      @data['stack']
    end

    # @return [String]
    def version
      @data['version']
    end

    # @return [Boolean]
    def root?
      parent.nil?
    end

    # @return [String]
    def parent
      @data.dig('parent', 'name')
    end

    # @return [Hash]
    def variables
      @data['variables']
    end

    # @return [Array<Hash>]
    def services
      @data['services']
    end

    # @return [Array<String>]
    def service_names
      @data['services'].map { |s| s['name']}
    end

    # @return [Hash]
    def data
      @data.dup
    end
  end
end
