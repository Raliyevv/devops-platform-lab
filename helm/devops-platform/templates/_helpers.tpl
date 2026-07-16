{{- define "devops-platform.name" -}}
devops-platform
{{- end }}

{{- define "devops-platform.fullname" -}}
{{ include "devops-platform.name" . }}
{{- end }}

{{- define "devops-platform.labels" -}}
app.kubernetes.io/name: {{ include "devops-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "devops-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devops-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
