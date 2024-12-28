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
end
