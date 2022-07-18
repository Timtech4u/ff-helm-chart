package argo

import (
    "list"
    "encoding/yaml"
    kustomize "sigs.k8s.io/kustomize/api/types"
    argoApp "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    argoAppSet "github.com/argoproj/argo-cd/v2/pkg/apis/applicationset/v1alpha1"
    ffHelm "fireflies.ai/helm-charts/charts/app"
)

#Schema: #FFApplication | #FFAppSet | #FFKustomize

#FFKustomize: {
    kustomize.#Kustomization
    apiVersion: "kustomize.config.k8s.io/v1beta1"
    kind: "Kustomization"
}

#FFApplication : {
    argoApp.#Application
    apiVersion: "argoproj.io/v1alpha1"
    kind: "Application"
    metadata: metav1.#ObjectMeta
    #FFValidValues
}

#FFValidValues: {
    spec: source: helm?: values: string
    _validate : spec.source.helm.values
    _validate : yaml.Validate(ffHelm.#App)

    _parsed : yaml.Unmarshal(spec.source.helm.values)

    // Make sure env var is unique on either extraEnv and extraSecrets
    _envVarNameMustBeUnique : true
    _envVarNameMustBeUnique : list.UniqueItems([for _, i in _parsed.extraEnv {i.name}, for _, i in _parsed.extraSecrets {i.name}])
}

#FFAppSet : {
    apiVersion: "argoproj.io/v1alpha1"
    kind: "ApplicationSet"
    metadata: metav1.#ObjectMeta
    spec: #AppSetSpec
}

#AppSetSpec: {
    generators: [...#ApplicationSetGenerator]
    template: #AppSetSpecTemplate
}

#AppSetSpecTemplate: {
    argoAppSet.#ApplicationSetTemplate
    #FFValidValues
}

#ApplicationSetGenerator: {
    argoAppSet.#ApplicationSetGenerator
    list?: #ListGenerator
}

#ListGenerator: {
    argoAppSet.#ListGenerator
    elements?: [...#ListGeneratorElement]
}

#ListGeneratorElement: {
    [string]: string
}