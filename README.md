# Golang Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for running [Go](https://golang.org) code directly on your agent machines. It does this by setting the `$GOPATH`, and checking out your project into the correct directory structure.

See also the [golang-build plugin](https://github.com/buildkite-plugins/golang-build-buildkite-plugin).

## Example

The following pipeline will ensure the project is checked out into the correct `$GOPATH/src` directory before running the `go test` command:

```yml
steps:
  - command: go test
    plugins:
      golang#v0.3:
        import: github.com/my-org/my-project
```

## Options

### `import`

The import path to use when the project is checked out. For example, if you develop in `$GOPATH/src/github.com/my-org/my-project` then the `import` option should be `github.com/my-org/my-project`.

## Roadmap

* Prepend to existing `$GOPATH`s instead of replacing

## License

MIT (see [LICENSE](LICENSE))
