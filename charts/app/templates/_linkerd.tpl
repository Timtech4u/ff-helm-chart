{{- define "linkerd.config" -}}
{{- range $key, $val := .Values.linkerd -}}
config.linkerd.io/{{ $key }}: {{ $val | quote }}
{{ end -}}
{{- end }}