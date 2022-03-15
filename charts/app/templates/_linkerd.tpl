{{- define "linkerd.config" -}}
{{- range $key, $val := .Values.linkerd -}}
{{- if eq $key "inject" -}}
linkerd.io/inject: {{ $val | quote }}
{{ else -}}
config.linkerd.io/{{ $key }}: {{ $val | quote }}
{{ end -}}
{{- end -}}
{{- end -}}