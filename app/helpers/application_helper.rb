module ApplicationHelper
  def render_icon(icon_name, options = {})
    inline_svg_tag("#{icon_name}.svg", options)
  end
end
