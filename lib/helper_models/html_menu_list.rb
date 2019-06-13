# frozen_string_literal: true

module HelperModel
  class HtmlMenuList
    attr_reader :items

    def initialize
      @items = []
      @default_options = {
        link_params: {},
        is_active: ->(item) {
          item[:controller] == params[:controller].to_sym && item[:action] == params[:action].to_sym
        }
      }
    end

    def item(label, controller, action, options = {})
      options = @default_options.deep_merge(options)
      detect_active_proc = ->(item) {
        item[:controller] == params[:controller].to_sym && item[:action] == params[:action].to_sym
      }
      @items << {
        label: label,
        controller: controller,
        action: action,
        link: {
          controller: controller,
          action: action
        }.merge(options[:link_params]),
        icon: options[:icon] || nil,
        is_active: options[:is_active] || detect_active_proc
      }
    end
  end
end
