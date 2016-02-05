#!/usr/bin/env roundup
source tests/helper.sh

describe "configuring options"

before() {
  server=""
  save_settings
  mkdir "/tmp/alfred-jira-shared-config-dir"
}

after() {
  rm -f "$our_dir/config"
  rm -rf "/tmp/alfred-jira-shared-config-dir"
}

################################################################################

it_defaults_when_setting_shared_config_dir_with_no_value() {
  set_option "shared_config_dir" ""
  test "$shared_config_dir" = ""
}

it_errors_when_setting_shared_config_dir_to_nonexistent_directory() {
  bash jira.sh configure shared_config_dir /tmp/alfred-jira-does-not-exist | grep "ERROR"
}


it_sets_shared_config_dir_to_value() {
  set_option "shared_config_dir" "/tmp/alfred-jira-shared-config-dir"
  test "$shared_config_dir" = "/tmp/alfred-jira-shared-config-dir"
}

################################################################################

it_sets_server_to_value() {
  set_option "server" "server999"
  test "$server" = "server999"
}

################################################################################

it_errors_when_passing_invalid_key() {
  bash jira.sh configure invalid bogus | grep "ERROR"
}

