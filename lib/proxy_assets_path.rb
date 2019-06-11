# frozen_string_literal: true

require 'rack/proxy'

class ProxyAssetsPath < Rack::Proxy
  def perform_request(env)
    is_images = env['PATH_INFO'].include?('/images/')
    is_sockjs = env['PATH_INFO'].start_with?('/sockjs-node/')
    if is_images || is_sockjs
      unless Rails.env.production? || Rails.env.staging?
        dev_server = env['HTTP_HOST'].gsub(':3000', ':3035')
        env['HTTP_HOST'] = dev_server
        env['HTTP_X_FORWARDED_HOST'] = dev_server
        env['HTTP_X_FORWARDED_SERVER'] = dev_server
      end
      env['PATH_INFO'] = '/public/assets/images/' + env['PATH_INFO'].split('/').last if is_images
      super
    else
      @app.call(env)
    end
  end
end
