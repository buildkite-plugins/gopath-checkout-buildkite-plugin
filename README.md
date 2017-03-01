# Golang Buildkite Plugin

__This is designed to run with Buildkite Agent v3.x beta. Plugins are not yet supported in Buildkite Agent v2.x.__

A [Go](https://golang.org) Buildkite Agent plugin that sets your `$GOPATH` and checks out your project into the correct directory structure.

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
