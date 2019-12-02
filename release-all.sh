#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

(flutter build apk && flutter build ios)

(cd android && fastlane internal)
(cd ios && fastlane beta)