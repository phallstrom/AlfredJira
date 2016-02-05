#!/usr/bin/env roundup
source tests/helper.sh

describe "load/save options"

before() {
  rm -f "$our_dir/config"
  mkdir "/tmp/alfred-jira-shared-config-dir"
}

after() {
  rm -f "$our_dir/config"
  rm -rf "/tmp/alfred-jira-shared-config-dir"
}

it_loads_default_settings() {
  load_settings
  test "$server" = ""
  test "$shared_config_dir" = ""
}

it_saves_settings() {
  server="server123"
  shared_config_dir="/tmp/alfred-jira-shared-config-dir"
  save_settings
  unset server shared_config_dir
  load_settings
  test "$server" = "server123"
  test "$shared_config_dir" = "/tmp/alfred-jira-shared-config-dir"
}
