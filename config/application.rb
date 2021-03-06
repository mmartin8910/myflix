
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix

  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true

    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework :rspec,
          :fixtures => true,
          :view_specs => true,
          :helper_specs => true,
          :routing_specs => true,
          :controller_specs => true,
          :request_specs => true
      g.fixture_replacement :fabrication, :dir => 'spec/fabricators'
    end
  end
end
