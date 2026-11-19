{{- define "docs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "docs.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "docs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "docs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "docs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "docs.labels" -}}
helm.sh/chart: {{ include "docs.chart" . }}
{{ include "docs.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | trunc 63 | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* The image as repository:tag@digest; tag and digest are both required. */}}
{{- define "docs.image" -}}
{{- $img := .Values.image -}}
{{- $repository := required "image.repository is required" $img.repository -}}
{{- $tag := required "image.tag is required" $img.tag -}}
{{- $digest := required "image.digest is required" $img.digest -}}
{{- printf "%s:%s@%s" $repository $tag $digest -}}
{{- end -}}
