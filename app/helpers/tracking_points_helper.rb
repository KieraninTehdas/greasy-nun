module TrackingPointsHelper
  def status_icon(tracking_point)
    unless tracking_point.has_data?
      return "help-circle"
    end

    if tracking_point.succeeded?
      "check"
    else
      "x"
    end
  end

  def tracking_point_dom_id(tracking_point, habit_id)
    "#{habit_id}-#{tracking_point.date_point}"
  end
end
