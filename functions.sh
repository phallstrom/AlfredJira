#!/bin/bash

OUR_DIR=$(cd $(dirname "$0"); pwd)
[[ ! -d "$PREF_DIR" ]] && mkdir -p "$PREF_DIR" 2>/dev/null

function echo_start_items() {
  echo '<?xml version="1.0"?>'
  echo '<items>'
}

function echo_end_items() {
  echo '</items>'
}

function echo_item() { # uid, arg, valid, autocomplete, title, subtitle, icon
  echo "<item uid='$1' arg='$2' valid='$3' autocomplete='$4'>"
  echo "<title>$5</title>"
  echo "<subtitle>$6</subtitle>"
  echo "<icon>${7-icon.png}</icon>"
  echo "</item>"
}


#
# Set default settings, then load user's custom settings if config file exists.
#
function load_settings
{
  server=""
  shared_config_dir=""
  if [[ -r "$PREF_DIR/config" ]]; then
    source "$PREF_DIR/config"
  fi
  if [[ -n "$shared_config_dir" && -r "$shared_config_dir/config" ]]; then
    source "$shared_config_dir/config"
  fi
}

#
#
#
function save_settings
{
  if [[ -n "$shared_config_dir" ]]; then
  cat << EOT > "$shared_config_dir/config"
server="$server"
EOT
  cat << EOT > "$PREF_DIR/config"
shared_config_dir="$shared_config_dir"
EOT
  else
  cat << EOT > "$PREF_DIR/config"
server="$server"
EOT
  fi

}

#
#
#
function set_option
{
  local key=$1
  local val=$2

  case $key in
    shared_config_dir)
      if [[ -z "$val" ]]; then
        shared_config_dir=""
      elif [[ ! -d "$val" ]]; then
        echo "ERROR: '$val' must be an existing directory."
        exit
      else
        shared_config_dir=$val
      fi
      ;;
    server)
      if [[ -z "$val" ]]; then
        server="api.github.com"
      else
        server=$val
      fi
      ;;
    *)
      echo "ERROR: Invalid option '$key'. Valid options are:"
      echo "server [string]"
      echo "shared_config_dir [string]"
      ;;
  esac

}

#
# Parse the command line and set all global variables we will need to complete
# the script.
#
function parse_cli()
{
  action=""

  local arg1
  local arg2
  local arg3

  IFS=" " read arg1 arg2 arg3 <<< $*

  case $arg1 in
    help)
      action="help"
      ;;
    configure)
      action="configure"
      key=$arg2
      val=$arg3
      ;;
    *)
      action="jira"
      ;;
  esac

}


#
#
#
function open_jira_ticket
{
  ticket=`pbpaste`
  open https://$server/browse/$ticket
}
