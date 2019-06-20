# frozen_string_literal: true

module BulmaHelper
  def field(options = {}, &block)
    options[:class] = ['field', options[:class]].compact.uniq
    content_tag(:div, capture(&block), class: options[:class])
  end

  def field_group(options = {}, &block)
    options[:class] ||= ['is-grouped', options[:class] || nil].compact.uniq
    options[:class] << "is-grouped-#{options[:align]}" if options[:align]
    field(options, capture(&block))
  end

  def field_horizontal(label, options = {}, &block)
    options[:class] = ['field', 'is-horizontal', options[:class]].compact.uniq
    content_tag(:div, class: options[:class]) do
      concat(
        content_tag(:div, class: 'field-label') do
          content_tag(:label, label, class: 'label')
        end
      )
      concat(
        content_tag(:div, class: 'field-body') do
          field capture(&block)
        end
      )
    end
  end
end
