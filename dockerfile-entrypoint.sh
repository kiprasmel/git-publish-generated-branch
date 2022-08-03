#!/usr/bin/env bash

# see https://github.com/webispy/checkpatch-action/commit/e605aacea0586dfb5e80e842aa453b00aed811f4
git config --global --add safe.directory /github/workspace

bash -c "/git-publish-generated-branch $*"
