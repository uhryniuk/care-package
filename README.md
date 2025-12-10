# Helix Care Package

This is a [Dropzone](https://github.com/uhryniuk/dropzone) care package for the [Helix](https://helix-editor.com/) text editor.

It packages the static binaries for Helix into a container image that can be installed and managed by Dropzone.

## Usage

### Building Locally

You can build the package locally using the Dropzone CLI:

```bash
dropzone build helix .
```

You can also specify a specific Helix version (defaults to 25.07.1):

```bash
dropzone build helix . --build-arg HELIX_VERSION=23.10
```

### Installing

To install the package:

```bash
dropzone install helix
```

After installation, the `hx` command will be available in your path (provided `~/.dropzone/bin` is in your PATH).

```bash
hx --version
```

## GitHub Actions

This repository is configured with GitHub Actions to automate the build and release process.

1.  **Build and Publish**: Automatically builds and pushes the care package to the GitHub Container Registry (GHCR) whenever code is pushed to `main` or a new tag starting with `v` is pushed.
2.  **Create Tag**: A manual workflow ("Create Tag and Trigger Build") allows you to easily create a new git tag (e.g., `v25.07.1`), which will kick off the build and publish workflow.