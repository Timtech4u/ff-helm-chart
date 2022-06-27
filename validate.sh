#!/bin/env sh

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