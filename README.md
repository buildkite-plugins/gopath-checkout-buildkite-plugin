# GOPATH Checkout Buildkite Plugin [![Build status](https://badge.buildkite.com/dfa888829723dcf23369cc29c9f375f1206bedca625c7f0c1e.svg?branch=master)](https://buildkite.com/buildkite/plugins-gopath-checkout)

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for running [Go](https://golang.org) code directly on your agent machines. It does this by setting the `$GOPATH`, and checking out your project into the correct directory structure.

See also the [golang-build plugin](https://github.com/buildkite-plugins/golang-build-buildkite-plugin).

## Example

The following pipeline will ensure the project is checked out into the correct `$GOPATH/src` directory before running the `go test` command:

```yml
steps:
  - command: go test
    plugins:
      - gopath-checkout#v2.0.0:
          import: github.com/my-org/my-project
```

## Configuration

### `import`

The import path to use when the project is checked out. For example, if you develop in `$GOPATH/src/github.com/my-org/my-project` then the `import` option should be `github.com/my-org/my-project`.

## Compatibility

| Elastic Stack | Agent Stack K8s | Hosted (Mac) | Hosted (Linux) | Notes |
| :-----------: | :-------------: | :----: | :----: |:---- |
| ✅ | ❌ | ✅ | ✅ | **K8s** Uses `pre-checkout` hook, which runs in separate `checkout` container from commands |

- ✅ Fully supported (all combinations of attributes have been tested to pass)
- ⚠️ Partially supported (some combinations cause errors/issues)
- ❌ Not supported

## Developing

To run testing, shellchecks and plugin linting use use `bk run` with the [Buildkite CLI](https://github.com/buildkite/cli).

```bash
bk run
```

Or if you want to run just the tests, you can use the docker [Plugin Tester](https://github.com/buildkite-plugins/buildkite-plugin-tester):

```bash
docker run --rm -ti -v "${PWD}":/plugin buildkite/plugin-tester:latest
```

## Roadmap

* Prepend to existing `$GOPATH`s instead of replacing

## License

MIT (see [LICENSE](LICENSE))
