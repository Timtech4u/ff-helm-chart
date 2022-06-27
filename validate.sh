#!/bin/env bash

# Do it for all
cue vet -p argo ./argocd $1/*.yaml
RESULT=$?

# If fail, check one by one
if [ $RESULT -ne 0 ]; then
    set -e

    for yaml in $1/*.yaml
    do
        FILENAME="$(basename $yaml)"
        if [ $FILENAME = "kustomization.yaml" ]
        then
            continue;
        else
            echo "Evaluating $FILENAME"
            cue vet -p argo ./argocd $yaml
        fi
    done
fi