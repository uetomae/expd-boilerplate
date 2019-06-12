# frozen_string_literal: true

class WebpackAsset
  class << self
    delegate :fetch, to: :manifest

    def manifest
      JSON.parse(Rails.env.development? ? read_manifest_dev : read_manifest)
    end

    def read_manifest
      @read_manifest ||= File.read('public/assets/manifest.json')
    end

    # :nocov:
    def read_manifest_dev
      OpenURI.open_uri('http://0.0.0.0:3035/assets/manifest.json').read
    end
    # :nocov:

    def exist?(entry)
      manifest.key?(entry)
    end
  end
end
