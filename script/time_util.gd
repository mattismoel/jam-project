class_name TimeUtil


## Returns input time left as format min:sec, i.e. 65 secs -> 01:05.
static func format_time_left(time_left: float) -> String:
  var mins := floori(time_left / 60.0)
  var secs := int(time_left) % 60

  return "%02d:%02d" % [mins, secs]
