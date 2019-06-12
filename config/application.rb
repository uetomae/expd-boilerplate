require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 5.2
    config.paths.add Rails.root.join('lib').to_s, eager_load: true
    config.api_only = false
    config.i18n.default_locale = :ja
    config.time_zone = 'Asia/Tokyo'
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.template_engine :haml
      g.test_framework false
    end
  end
end
