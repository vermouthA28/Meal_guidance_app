module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "primary"
    when "error"
      "danger"
    end
  end
end