package argo

import "encoding/yaml"

import argoApp "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

import ffHelm "fireflies.ai/helm-charts/charts/app"

argoApp.#Application
spec: source: helm: values: string
_validate : spec.source.helm.values
_validate : yaml.Validate(ffHelm.#App)