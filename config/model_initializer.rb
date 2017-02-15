module ModelInitializer
  def load_models
    deps
    Dir['./app/models/*.rb'].each &proc{ |model| require model }
  end

  def deps
    require 'active_record'
    require 'kaminari/core'
  end
end