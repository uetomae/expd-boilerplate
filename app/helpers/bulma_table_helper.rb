# frozen_string_literal: true

module BulmaTableHelper
  def table_for(collection, options = {})
    tbl = HelperModels::HtmlTable.new(collection)
    yield tbl
    options = {
      class: %w[table is-striped]
    }.deep_merge(options)
    content_tag(:table, options) do
      thead = content_tag(:thead) do
        tbl.heads.each do |th|
          concat content_tag(:th, th)
        end
      end
      tbody = content_tag(:tbody) do
        collection.each do |rec|
          tr = content_tag(:tr) do
            tbl.columns.each do |column|
              concat content_tag(:td, instance_exec(rec, &column))
            end
          end
          concat tr
        end
      end
      concat thead
      concat tbody
    end
  end
end
