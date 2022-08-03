# git-publish-generated-branch

situation:

- you have something (source code, template, etc) that generates a build/binary/static assets/etc.
- you want to store this generated output in a different branch,
- you want these contents to be right at the root of the repository (so that the output path is inlined / other tools don't need to know it, & instead they only need the branch name)

here, you can use git-publish-generated-branch.

- it expects that you've generated your build,
- takes it's path,
- creates or re-uses a branch of a specific name that's derived from the current branch,
- overrides the root dir of the repo to the built contents,
- commits the change and
- pushes it to the remote branch.

## Usage

```sh
$ git-publish-generated-branch --help

usage:

git-publish-generated-branch <BUILD_DIR> --branch-prefix <PREFIX="x-build/">
git-publish-generated-branch <BUILD_DIR> --branch <FULL_NAME_OF_NEW_BRANCH="{prefix}{current-branch}">

required:
    [--dir] BUILD_DIR


optional:
    -p, --branch-prefix                    = "x-build/"
    -b, --branch                           = "{prefix}{current-branch}"

        --no-exit-on-changes-outside-build = 0 (exits if changes detected outside build dir)
        --extra-commit-body                = ""
        --remote                           = origin

    -V, --version
    -h, --help


git-publish-generated-branch v0
```

## Usage as GitHub Action

```yml
# your-workflow.yml

name: <your-workflow>

on:
  workflow_dispatch:
    # manual trigger
  push:
    # on push to any branch, excluding our generated ones
    branches-ignore:
      - 'x-build/*'

      # TODO - will need this after testing.
      # or a general way to specify the default branch.
      # because too much activity, even w/ pull --rebase,
      # can become incorrect.
      # and in general, u shouldn't need to load from master,
      # since it's what's in production already.
      #
      # - "master"

jobs:	
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
        with:
          # see https://github.com/actions/checkout/issues/217
          # TODO optimise perf?
          # TODO also fix for v3, because currently works only with v2 (because of https://github.com/actions/checkout/issues/217#issuecomment-634802933 )
          fetch-depth: 0

      - run: |
          git config --global user.email "network-overrides+v0@example.com"
          git config --global user.name "network-overrides-bot"

      # setup project
      # install deps
      # create the "build" folder

      # and then:

      - uses: kiprasmel/git-publish-generated-branch@v0
        with:
          ARGS: '--dir "build" --branch-prefix "x-build/"'

```

## Background

this tool works similarly to how github pages create another branch "gh-pages" and store static contents directly there, such that they're available on `<username>.github.io/`.

it was originally developed to help implement the following RFC:
- https://github.com/miguel-silva/network-overrides/pull/5
