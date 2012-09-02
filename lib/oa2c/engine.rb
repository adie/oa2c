module Oa2c
  class Engine < Rails::Engine
    isolate_namespace Oa2c
    config.orm = :mongoid
  end
end
