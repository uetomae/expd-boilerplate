# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
SimpleForm.setup do |config|
  config.button_class = 'button'
  config.error_notification_class = 'notification is-danger'

  config.wrappers :default, tag: 'div', class: 'field' do |b|
    b.use      :placeholder
    b.optional :icon_left
    b.optional :icon_right
    b.optional :size
    b.optional :color

    b.use      :label, class: 'label'
    b.use      :input
    b.use      :error, wrap_with: { tag: 'p', class: 'help is-danger' }
    b.optional :help
  end

  config.wrappers :horizontal, tag: 'div', class: 'field is-horizontal', error_class: 'is-danger' do |b|
    b.use      :placeholder
    b.optional :icon_left
    b.optional :icon_right
    b.optional :size
    b.optional :color

    b.wrapper :label, tag: 'div', class: 'field-label' do |bl|
      bl.use :label, class: 'label'
    end
    b.wrapper :input, tag: 'div', class: 'field-body' do |bi|
      bi.wrapper :input, tag: 'div', class: 'field' do |bf|
        bf.use      :input
        bf.optional :help
        bf.use      :error, wrap_with: { tag: 'p', class: 'help is-danger' }
      end
    end
  end

  module BulmaBasicComponent
    def help(_wrapper_options = nil)
      @help ||= begin
                  template.content_tag(:p, options[:help], class: class_with_shape('help')) if options[:help]
                end
    end

    def size(_wrapper_options = nil)
      @shape_classes ||= [@shape_classes, "is-#{options[:size]}"].compact.uniq if options[:size]
      nil
    end

    def color(_wrapper_options = nil)
      @shape_classes ||= [@shape_classes, "is-#{options[:color]}"].compact.uniq if options[:color]
      nil
    end

    def class_with_shape(*classes)
      [@shape_classes || [], classes].compact.uniq.join(' ')
    end
  end
  SimpleForm.include_component(BulmaBasicComponent)

  module SimpleForm
    class FormBuilder
      def submit_button(*args, &block)
        opts = args.extract_options!.dup
        color = opts[:color] || 'primary'
        opts[:class] = [SimpleForm.button_class, "is-#{color}", opts[:class]].compact.uniq
        args << opts
        template.content_tag(:div, submit(*args, &block), class: 'control')
      end
    end
  end

  module BulmaInputWrapper
    def input(_wrapper_options = nil)
      icon_left = options[:icon_left]
      icon_right = options[:icon_right]
      classes = %w[control]
      classes << 'has-icons-left' if icon_left
      classes << 'has-icons-right' if icon_right
      template.content_tag(:div, class: classes.join(' ')) do
        template.concat super(class: class_with_shape('input'))
        template.concat small_icon(icon_left, :left) if icon_left
        template.concat small_icon(icon_right, :right) if icon_left
      end
    end

    def icon_left(_wrapper_options = nil); end

    def icon_right(_wrapper_options = nil); end

    def small_icon(icon_name, align)
      template.content_tag(:span, class: "icon is-#{align}") do
        template.content_tag(:i, nil, class: "fas fa-#{icon_name}")
      end
    end
  end
  class StringInput < SimpleForm::Inputs::StringInput
    include BulmaInputWrapper
  end
  class NumericInput < SimpleForm::Inputs::NumericInput
    include BulmaInputWrapper
  end
  class PasswordInput < SimpleForm::Inputs::PasswordInput
    include BulmaInputWrapper
  end

  class TextInput < SimpleForm::Inputs::TextInput
    def input(_wrapper_options = nil)
      template.content_tag(:div, class: 'control') do
        super(class: 'textarea')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
