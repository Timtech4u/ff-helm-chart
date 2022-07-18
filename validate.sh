#!/bin/env bash

echo "Validating Manifests on $1"

# Do it for all
cue vet -E -p argo -d '#Schema' ./argocd $1/*.yaml
RESULT=$?

# If fail, check one by one
if [ $RESULT -ne 0 ]; then
    set -e

    for yaml in $1/*.yaml
    do
        FILENAME="$(basename $yaml)"
        echo "Evaluating $FILENAME"
        cue vet -p argo -d '#Schema' ./argocd $yaml
    done
fi

echo "Validation succeeded"