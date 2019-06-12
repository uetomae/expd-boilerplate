# frozen_string_literal: true

module BulmaHelper
  def field(options = {}, &block)
    options[:class] = ['field', options[:class]].compact.uniq
    content_tag(:div, capture(&block), class: options[:class])
  end

  def field_group(options = {}, &block)
    options[:class] ||= ['is-grouped', options[:class] || nil].compact.uniq
    options[:class] << "is-grouped-#{options[:align]}" if options[:align]
    field(options, &block)
  end
end
