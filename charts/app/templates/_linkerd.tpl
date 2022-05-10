{{- define "linkerd.config" -}}
{{- range $key, $val := .Values.linkerd -}}
{{- if eq $key "inject" -}}
linkerd.io/inject: {{ $val | quote }}
{{ else -}}
config.linkerd.io/{{ $key }}: {{ $val | quote }}
{{ end -}}
{{- end -}}
config.alpha.linkerd.io/proxy-wait-before-exit-seconds: {{ .Values.terminationGracePeriodSeconds | quote }}
{{- end -}}