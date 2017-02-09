require_relative 'lib/application'

class App
  def self.instance
    @app ||= Lib::Application
  end
end
