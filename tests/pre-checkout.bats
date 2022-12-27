#!/usr/bin/env bats

load "${BATS_PLUGIN_PATH}/load.bash"

export BUILDKITE_PLUGIN_GOPATH_CHECKOUT_IMPORT=my-dir
export BUILDKITE_BUILD_CHECKOUT_PATH="/builds/my-pipeline"
export BUILDKITE_PIPELINE_SLUG="my-pipeline"

@test "all variables are printed out" {
  run "$PWD"/hooks/pre-checkout
  
  assert_success
  assert_output --partial "GOPATH=/builds/.golang/my-pipeline"
  assert_output --partial "BUILDKITE_BUILD_CHECKOUT_PATH=/builds/.golang/my-pipeline/src/my-dir"
  assert_output --partial "PATH=$PATH:/builds/.golang/my-pipeline/bin"
  assert_output --partial "GOBIN=/builds/.golang/my-pipeline/bin"
}

@test "all variables change values" {
  env | sort > "${BATS_TMP_DIR}"/before
  run bash -c ". \"$PWD\"/hooks/pre-checkout; env | sort > \"${BATS_TMP_DIR}\"/after"
  [ "$(grep GOPATH "${BATS_TMP_DIR}"/before)" != "$(grep GOPATH "${BATS_TMP_DIR}"/after)" ]
  [ "$(grep BUILDKITE_BUILD_CHECKOUT_PATH "${BATS_TMP_DIR}"/before)" != "$(grep BUILDKITE_BUILD_CHECKOUT_PATH "${BATS_TMP_DIR}"/after)" ]
  [ "$(grep PATH "${BATS_TMP_DIR}"/before)" != "$(grep PATH "${BATS_TMP_DIR}"/after)" ]
  [ "$(grep GOBIN "${BATS_TMP_DIR}"/before)" != "$(grep GOBIN "${BATS_TMP_DIR}"/after)" ]

  assert_success
}

@test "all variables have the correct values" {
  run bash -c ". \"$PWD\"/hooks/pre-checkout; env | sort > \"${BATS_TMP_DIR}\"/after"
  
  assert_success
  grep 'GOPATH=/builds/.golang/my-pipeline' "${BATS_TMP_DIR}"/after
  grep 'BUILDKITE_BUILD_CHECKOUT_PATH=/builds/.golang/my-pipeline/src/my-dir' "${BATS_TMP_DIR}"/after
  [[ "$(grep PATH "${BATS_TMP_DIR}"/after)" =~ (^|:)/builds/.golang/my-pipeline/bin(:|$) ]]
  grep 'GOBIN=/builds/.golang/my-pipeline/bin' "${BATS_TMP_DIR}"/after
}