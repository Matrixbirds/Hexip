require 'mustermann'
require 'ostruct'

module Lib
  module Router
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def get(url, &block)
        routes 'GET', url, &block
      end

      def post(url, &block)
        routes 'POST', url, &block
      end

      def put(url, &block)
        routes 'PUT', url, &block
      end

      def delete(url, &block)
        routes 'DELETE', url, &block
      end

      def routes(verb, url, &block)
        @@routes ||= {}
        (@@routes[verb] ||= []) << [url, block]
      end

      def find_action(req)
        uri, verb = serialize_request(req)
        path, action = [*@@routes[verb]&.select do |path, _|
          match(path, uri)
        end]&.flatten
        -> { [404, {'Content-Type' => 'text/plain'}, 'Not Found'] } unless action&.respond_to?(:call)
        pattern = match(path, uri)
        new_req = generate_request_object(req, pattern)
        action.call new_req
      end

      private

      def match(router_path, uri)
        Mustermann.new(router_path).peek_match(uri)
      end

      def serialize_request(req)
        [req.env['REQUEST_URI'], req.env['REQUEST_METHOD']]
      end

      def generate_request_object(req, pattern)
        u = OpenStruct.new
        u.params = Hash[pattern&.names&.zip(pattern&.captures)]
        u.req = req
        u
      end
    end
  end
end
