# frozen_string_literal: true

module BulmaMenuListHelper
  def menu_list
    menu_list = HelperModel::HtmlMenuList.new
    yield menu_list
    list_items = menu_list.items.map do |item|
      is_active = instance_exec(item, &item[:is_active])
      content_tag(:li) do
        link_to(item[:link], class: (is_active ? 'is-active' : nil)) do
          if item[:icon]
            concat content_tag(:span, item[:icon], class: 'icon')
            concat content_tag(:span, item[:label])
          else
            item[:label] unless item[:icon]
          end
        end
      end
    end
    safe_join list_items, nil
  end
end
