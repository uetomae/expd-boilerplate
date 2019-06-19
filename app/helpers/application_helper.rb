# frozen_string_literal: true

module ApplicationHelper
  def title(value = nil)
    if value
      content_for :title, value
      return value
    end
    return content_for(:title) if content_for?(:title)

    t("#{controller.controller_name}.#{controller.action_name}.title", default: t(:site_name))
  end

  def title_with_sitename
    site_name = t(:site_name)
    title == site_name ? site_name : "#{title} - #{site_name}"
  end

  def localize(datetime)
    tz = current_user ? current_user.time_zone : 'Asia/Tokyo'
    datetime.in_time_zone(tz)
  end

  def route_exists?(path)
    Rails.application.routes.recognize_path(path)
  rescue ActionController::RoutingError
    false
  end
end
