
Myflix::Application.configure do

  config.cache_classes = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  config.active_support.deprecation = :log

  config.assets.compress = false

  config.assets.debug = true

  config.eager_load = false
end
