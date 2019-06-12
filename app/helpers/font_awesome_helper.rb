# frozen_string_literal: true

module FontAwesomeHelper
  def fa_icon(category, key, options = {})
    icon_classes = %w[icon]
    icon_classes << "is-#{options[:size]}" if options.key?(:size)
    content_tag(:span, class: icon_classes) do
      content_tag(:i, nil, class: "#{category} fa-#{key}")
    end
  end

  def fas_icon(key, options = {})
    fa_icon(:fas, key, options)
  end

  def far_icon(key, options = {})
    fa_icon(:far, key, options)
  end

  def fal_icon(key, options = {})
    fa_icon(:fal, key, options)
  end

  def fab_icon(key, options = {})
    fa_icon(:fab, key, options)
  end
end
