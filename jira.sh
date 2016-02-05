#!/bin/bash

PREF_DIR="$HOME/Library/Application Support/Alfred 2/Workflow Data/pjkh.jira"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source functions.sh
load_settings
parse_cli $* 

if [[ -z "$server" && "$action" != "configure" && "$action" != "help" ]]; then
  echo "You need to setup and configure Jira Type 'jira help' for details."
  exit
fi

case $action in
  help)
    open "https://github.com/phallstrom/AlfredJira#usage"
    exit
    ;;
  configure)

    newvalue=$(pbpaste | head -1 | iconv -c -t ASCII)

    if [[ -z "$key" && -z "$val" ]]; then
      echo_start_items
      echo_item "jira_config_server" "configure server $newvalue" "yes" "" "Your JIRA server is '$server'" "Select to change to '$newvalue'."
      echo_item "jira_config_shared_config_dir" "configure shared_config_dir $newvalue" "yes" "" "Your shared config directory is '$shared_config_dir'" "Select to change to '$newvalue'."
      echo_end_items
      exit
    fi

    set_option "$key" "$val"
    save_settings
    echo "Jira configuration has been updated."
    exit
    ;;
  jira)
    open_jira_ticket
    ;;
  *)
    echo "ERROR: Unknown action '$action'."
    ;;
esac
