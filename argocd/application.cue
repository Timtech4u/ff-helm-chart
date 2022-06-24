package argo

import "list"
import "encoding/yaml"

import argoApp "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

import ffHelm "fireflies.ai/helm-charts/charts/app"

argoApp.#Application
spec: source: helm: values: string
_validate : spec.source.helm.values
_validate : yaml.Validate(ffHelm.#App)

_parsed : yaml.Unmarshal(spec.source.helm.values)

// Make sure env var is unique on either extraEnv and extraSecrets
_envVarNameMustBeUnique : true
_envVarNameMustBeUnique : list.UniqueItems([for _, i in _parsed.extraEnv {i.name}, for _, i in _parsed.extraSecrets {i.name}])