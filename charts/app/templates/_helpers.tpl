{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "deployment.annotations" -}}
{{- range $key, $val := .Values.annotations -}}
{{ $key }}: {{ $val | quote }}
{{ end -}}
{{- end -}}

{{- define "app.annotations" -}}
argocd.argoproj.io/compare-options: IgnoreExtraneous
argocd.argoproj.io/sync-options: Prune=false
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $defaultName := .Chart.Name -}}
{{- if .Values.disableSuffix -}}
{{- $defaultName = .Release.Name -}}
{{- end -}}
{{- $name := default $defaultName .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s" .Chart.Name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
fireflies.ai/app: {{ include "app.firefliesLabels" . }}
{{ include "app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end }}

{{- define "app.firefliesLabels" -}}
{{- if .Values.overrideArgoID -}}
{{- .Values.overrideArgoID -}}
{{- else if .Values.cluster -}}
{{- .Values.cluster }}-{{ .Release.Namespace }}-{{ .Release.Name }}
{{- else -}}
{{- .Release.Namespace }}-{{ .Release.Name }}
{{- end }}
{{- end -}}


{{/*
Selector labels
*/}}
{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
{{- if .Values.overrideArgoID }}
app.kubernetes.io/instance: {{ .Values.overrideArgoID }}
app.kubernetes.io/instance-name: {{ .Values.overrideArgoID }}-{{ .Release.Name }}
{{- else if .Values.cluster }}
app.kubernetes.io/instance: {{ .Values.cluster }}-{{ .Release.Namespace }}-{{ .Release.Name }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Namespace }}-{{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "app.secretName" -}}
{{ printf "env-%s" (include "app.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app.secretKeyName" -}}
{{ printf "env-%s-%s" (default .Release.Namespace .Values.overrideSecretNamespace) (include "app.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app.secretProject" -}}
{{- default "fireflies-ai" .Values.secretProject }}
{{- end }}