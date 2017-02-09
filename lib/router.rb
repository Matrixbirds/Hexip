require 'mustermann'
require 'ostruct'

module Lib
  module Router
    def self.included(base)
      base.extend ClassMethods
    end
    module ClassMethods

      def routes(url, &block)
        @@routes ||= {}
        @@routes[url] = block
      end

      def find_action(req)
        uri = URI(req.url).request_uri
        path, action = [*@@routes.select do |path, _|
          match(path, uri)
        end].flatten
        -> { [404, {'Content-Type' => 'text/plain'}, 'Not Found'] } unless action&.respond_to?(:call)
        pattern = match(path, uri)
        _new_req = OpenStruct.new
        _new_req.params = Hash[pattern.names.zip(pattern.captures)]
        _new_req.req = req
        action.call(_new_req)
      end

      private

      def match(router_path, uri)
        Mustermann.new(router_path).peek_match(uri)
      end
    end
  end
end
