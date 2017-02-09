module Lib
  class AbstractApplication
    include Lib::Router

    def proc
      raise NotImplementedError
    end

    def self.on_call
      alias_method :call, :proc
    end
  end
end
