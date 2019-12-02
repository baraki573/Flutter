#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# Rename tmdb_config.dart.sample file so that the project compiles
# (cd core/lib/src && mv tmdb_config.dart.sample tmdb_config.dart)

# Get all packages for core, mobile and web
(flutter packages get)

# Analyze core, mobile and web
# (dartanalyzer ./ --fatal-infos --fatal-warnings)


echo "--- Running tests in mobile... ---"
(flutter test)
