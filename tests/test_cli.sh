#!/usr/bin/env roundup
source tests/helper.sh

describe "command line parsing"

before() {
  unset action
}

it_parses_help() {
  parse_cli help
  test "$action"      = "help"
}

it_parses_configure() {
  parse_cli configure somekey someval
  test "$action"      = "configure"
  test "$key"         = "somekey"
  test "$val"         = "someval"
}

it_parses_with_zero_arguments() {
  parse_cli
  test "$action"       = "jira"
}

