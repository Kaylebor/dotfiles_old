function wttr
  if not argparse \
      'q/quiet' \
      'png' \
      'd/days=?!_validate_int --min 0 --max 2' \
      -- $argv
    return
  end

  # Set PNG format
  if test -n "$_flag_png"
    set -f png_extension ".png"
    set -f commands_separator "_"
    set -f params_separator "_"
  else
    set -f commands_separator "?"
    set -f params_separator "&"
  end

  set -f base_url wttr.in
  set -f number_days_forecast 1
  set -f default_params Fm

  for a in $argv
    switch $a
      case '*'
        set -f location $a
    end
  end

  # Indicate how many days: 0 (current only), 1 (today), 2 (today + tomorrow)
  if test -n "$_flag_days"
    set -f number_days_forecast $_flag_days
  else
    set -f number_days_forecast 1
  end

  if test -z "$location" -o -n "$_flag_quiet"
    # No need to show location queried when missing arguments, as it should be current location
    set -f silent_flag Q
  end
  if test -z "$location"
    set -f location (http ipinfo.io | jq -r '.ip')
  end

  set -f url_params "$default_params$number_days_forecast$silent_flag$png_extension"
  set -f full_url "$base_url/$location$commands_separator$url_params"
  http -b $full_url
end
