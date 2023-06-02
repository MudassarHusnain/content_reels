require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Contentreels
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.lame_bin = '/path/to/lame'
    config.active_job.queue_adapter = :delayed_job
    config.active_storage.content_types_allowed_inline += [
      "audio/mp3",
      "audio/mp4",
      "audio/mpeg"
    ]
  end
end
