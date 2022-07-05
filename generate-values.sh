#!/bin/env sh

set -e

echo "Formatting"
cue fmt ./charts/fireflies/values

echo "Validating"
cue vet -p fireflies \
--strict \
-t googleProjectId=ff-private-cloud \
-t secretName=parse-admin-fireflies \
./charts/fireflies/values

echo "Generating"
cue export -p fireflies \
--out yaml \
-o ../values.yaml \
-f --strict \
-t googleProjectId=ff-private-cloud \
-t secretName=parse-admin-fireflies \
./charts/fireflies/values