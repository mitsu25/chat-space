require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace
  class Application < Rails::Application

    #controller生成時に不要ファイルを作成しない設定
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end

  end
end
