# frozen_string_literal: true

module HelperModel
  class HtmlTable
    attr_reader :heads, :columns

    def initialize(collection)
      @model = collection.model
      @heads = []
      @columns = []
    end

    def column(head, data, _options = {})
      @heads << head
      @columns << data
    end

    def column_for(attr, agent = nil, _options = {})
      @heads << @model.human_attribute_name(attr)
      @columns << (agent || ->(rec) { rec.send(attr) })
    end

    # rubocop:disable CyclomaticComplexity
    def column_as(key, link = nil, options = {})
      @heads << nil
      if options.empty? && link.is_a?(Hash)
        options = link
        link = nil
      end
      link_opts = options[:link_options] || {}
      hide_if = options[:hide_if] || ->(_rec) { false }
      case key
      when :show then
        link ||= ->(rec) { rec }
      when :edit then
        link ||= ->(rec) { { controller: rec.model_name.name.pluralize.downcase, action: :edit, id: rec.id } }
      when :destroy then
        link ||= ->(rec) { rec }
        link_opts = {
          method: :delete,
          data: { confirm: I18n.t('scaffold.destroy_confirm') }
        }.deep_merge(link_opts)
      end
      @columns << lambda { |rec|
        link_to t("scaffold.#{key}_html"), instance_exec(rec, &link), link_opts unless instance_exec(rec, &hide_if)
      }
    end
    # rubocop:enable CyclomaticComplexity
  end
end
