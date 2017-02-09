require_relative 'configuration'
module Lib
  class AbstractApplication
    include Lib::Router
    extend Lib::Configuration

    def proc
      raise NotImplementedError
    end

    def self.on_call
      alias_method :call, :proc
    end

    load_secrets
  end
end
