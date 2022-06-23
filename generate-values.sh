#!/bin/env sh
cue export -p fireflies \
--out yaml \
-o ../values.yaml \
-f --strict \
-t googleProjectId=ff-private-cloud \
-t secretName=parse-admin-fireflies \
./charts/fireflies/values