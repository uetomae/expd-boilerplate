# frozen_string_literal: true

class ExamplesController < ApplicationController
  layout 'fixed_top'

  def index; end

  def layout_naked
    render action: :content, layout: 'naked'
  end

  def layout_global_top
    render action: :content, layout: 'global_top'
  end

  def layout_fixed_top
    render action: :content, layout: 'fixed_top'
  end

  def toast_input; end

  def toast_message
    params.require(:toast).permit(:notify)
    type = params[:toast][:type].to_sym
    raise "Unknown type #{type}." unless %i[notice alert].include?(type)
    message = params[:toast][:notify]
    move_to_path = case params[:toast][:move_to]
                   when 'home' then root_path
                   when 'examples' then examples_path
                   when 'fixed_top' then examples_layout_fixed_top_path
                   end
    redirect_to move_to_path, type => message
  end
end
