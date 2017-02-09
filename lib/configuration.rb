require 'yaml'
module Lib
  module Configuration
    def load_secrets
      @config ||= YAML.parse_file(File.expand_path('../config/secrets.yml', File.dirname(__FILE__)))&.to_ruby&.fetch(ENV['RACK_ENV'])
    end

    def oauth
      config['oauth']
    end

    def github
      oauth['github']
    end

    def client_id
      github['client_id']
    end

    def secrets_key
      github['secrets_key']
    end

    alias_method :config, :load_secrets
  end
end
