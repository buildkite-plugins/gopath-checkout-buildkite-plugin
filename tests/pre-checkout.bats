#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

export BUILDKITE_PLUGIN_GOPATH_CHECKOUT_IMPORT=my-dir
export BUILDKITE_BUILD_CHECKOUT_PATH="/builds/my-pipeline"
export BUILDKITE_PIPELINE_SLUG="my-pipeline"

@test "sets \$GOPATH" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "GOPATH=/builds/.golang/my-pipeline"
}

@test "sets \$BUILDKITE_BUILD_CHECKOUT_PATH" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "BUILDKITE_BUILD_CHECKOUT_PATH=/builds/.golang/my-pipeline/src/my-dir"
}

@test "adds \$GOPATH/bin to \$PATH" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "PATH=$PATH:/builds/.golang/my-pipeline/bin"
}

@test "sets \$GOBIN" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "GOBIN=/builds/.golang/my-pipeline/bin"
}