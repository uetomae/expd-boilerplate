# frozen_string_literal: true

require 'open-uri'

module WebpackBundleHelper
  class BundleNotFound < StandardError; end

  def javascript_bundle_tag(entry, **options)
    path = asset_bundle_path_if_exist("#{entry}.js", 'application.js')
    options = {
      src: path,
      defer: true
    }.merge(options)
    options.delete(:defer) if options[:async]
    javascript_include_tag '', **options
  end

  def stylesheet_bundle_tag(entry, **options)
    path = asset_bundle_path_if_exist("#{entry}.css", 'style.css')
    options = {
      href: path
    }.merge(options)
    stylesheet_link_tag '', **options
  end

  def image_path(entry)
    asset_bundle_path "images/#{entry}"
  end

  private

  def asset_bundle_path(entry, **options)
    asset_base_path = '/assets/'
    asset_path(asset_base_path + WebpackAsset.fetch(entry), **options)
  end

  def asset_bundle_path_if_exist(entry, alternative, **options)
    return asset_bundle_path(entry, **options) if WebpackAsset.exist?(entry)
    asset_bundle_path(alternative, **options)
  end
end
