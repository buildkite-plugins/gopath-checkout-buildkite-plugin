#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

export BUILDKITE_PLUGIN_GOLANG_IMPORT=my-dir
export BUILDKITE_BUILD_CHECKOUT_PATH="/builds/my-pipeline"
export BUILDKITE_PIPELINE_SLUG="my-pipeline"

@test "sets the GOPATH" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "GOPATH=/builds/.golang/my-pipeline"
}

@test "sets the BUILDKITE_BUILD_CHECKOUT_PATH" {
  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "BUILDKITE_BUILD_CHECKOUT_PATH=/builds/.golang/my-pipeline/src/my-dir"
}

@test "adds GOPATH/bin to PATH" {
  export PATH=/bin

  run $PWD/hooks/pre-checkout
  
  assert_success
  assert_output --partial "PATH=/bin:/builds/.golang/my-pipeline/bin"
}