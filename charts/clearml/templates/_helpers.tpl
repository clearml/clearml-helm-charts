{{/*
Expand the name of the chart.
*/}}
{{- define "clearml.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clearml.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "clearml.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "clearml.labels" -}}
helm.sh/chart: {{ include "clearml.chart" . }}
{{ include "clearml.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "clearml.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Registry name
*/}}
{{- define "registryNamePrefix" -}}
  {{- $registryName := "" -}}
  {{- if .globalValues }}
    {{- if .globalValues.imageRegistry }}
      {{- $registryName = printf "%s/" .globalValues.imageRegistry -}}
    {{- end -}}
  {{- end -}}
  {{- if .imageRegistryValue }}
    {{- $registryName = printf "%s/" .imageRegistryValue -}}
  {{- end -}}
{{- printf "%s" $registryName }}
{{- end }}

{{/*
Reference Name (apiserver)
*/}}
{{- define "apiserver.referenceName" -}}
{{- include "clearml.fullname" . }}-apiserver
{{- end }}

{{/*
Selector labels (apiserver)
*/}}
{{- define "apiserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.fullname" . }}
app.kubernetes.io/instance: {{ include "apiserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (fileserver)
*/}}
{{- define "fileserver.referenceName" -}}
{{- include "clearml.fullname" . }}-fileserver
{{- end }}

{{/*
Selector labels (fileserver)
*/}}
{{- define "fileserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.fullname" . }}
app.kubernetes.io/instance: {{ include "fileserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (webserver)
*/}}
{{- define "webserver.referenceName" -}}
{{- include "clearml.fullname" . }}-webserver
{{- end }}

{{/*
Selector labels (webserver)
*/}}
{{- define "webserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.fullname" . }}
app.kubernetes.io/instance: {{ include "webserver.referenceName" . }}
{{- end }}

{{/*
Reference Name (apps)
*/}}
{{- define "clearmlApplications.referenceName" -}}
{{- include "clearml.fullname" . }}-apps
{{- end }}

{{/*
Selector labels (apps)
*/}}
{{- define "clearmlApplications.selectorLabels" -}}
app.kubernetes.io/name: {{ include "clearml.fullname" . }}
app.kubernetes.io/instance: {{ include "clearmlApplications.referenceName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "clearml.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "clearml.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create secret to access docker registry
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{/*
Create readiness probe auth token
*/}}
{{- define "readinessProbeAuth" }}
{{- printf "%s:%s" .Values.clearml.readinessprobeKey .Values.clearml.readinessprobeSecret | b64enc }}
{{- end }}

{{/*
Create configuration secret name
*/}}
{{- define "clearml.confSecretName" }}
{{- if .Values.clearml.existingSecret -}} {{ default "clearml-conf" .Values.clearml.existingSecret | quote }} {{- else -}} "clearml-conf" {{- end }}
{{- end }}

{{/*
compose file url
*/}}
{{- define "clearml.fileUrl" -}}
{{- if .Values.clearml.clientConfigurationFilesUrl }}
{{- .Values.clearml.clientConfigurationFilesUrl }}
{{- else if .Values.fileserver.ingress.enabled }}
{{- $protocol := "http" }}
{{- if .Values.fileserver.ingress.tlsSecretName }}
{{- $protocol = "https" }}
{{- end }}
{{- printf "%s%s%s" $protocol "://" .Values.fileserver.ingress.hostName }}
{{- else }}
{{- printf "%s%s%s%s" "http://" (include "fileserver.referenceName" .) ":" ( .Values.fileserver.service.port | toString ) }}
{{- end }}
{{- end }}

{{/*
Elasticsearch Service name
*/}}
{{- define "elasticsearch.servicename" -}}
{{- .Values.elasticsearch.clusterName }}-master
{{- end }}

{{/*
Elasticsearch Service port
*/}}
{{- define "elasticsearch.serviceport" -}}
{{- .Values.elasticsearch.httpPort }}
{{- end }}

{{/*
Elasticsearch Service schema
*/}}
{{- define "elasticsearch.servicescheme" -}}
{{- .Values.elasticsearch.httpScheme }}
{{- end }}

{{/*
Elasticsearch Connection string
*/}}
{{- define "elasticsearch.connectionstring" -}}
{{- if .Values.elasticsearch.enabled }}
{{- printf "[{\"host\":\"%s\",\"port\":%s,\"scheme\":\"%s\"}]" (include "elasticsearch.servicename" .) (include "elasticsearch.serviceport" .) (include "elasticsearch.servicescheme" .) | quote }}
{{- else }}
{{- .Values.externalServices.elasticsearchConnectionString | quote }}
{{- end }}
{{- end }}

{{/*
MongoDB Connection string
*/}}
{{- define "mongodb.connectionstring" -}}
{{- $authPrefix := "" -}}
{{- if .Values.mongodb.auth.enabled -}}
  {{- $authPrefix = printf "%s:%s@" .Values.mongodb.auth.rootUser .Values.mongodb.auth.rootPassword -}}
{{- end -}}
{{- if eq .Values.mongodb.architecture "standalone" -}}
  {{- printf "mongodb://%s%s-mongodb:27017" $authPrefix .Release.Name -}}
{{- else -}}
  {{- $connectionString := printf "mongodb://%s" $authPrefix -}}
  {{- range $i, $e := until (.Values.mongodb.replicaCount | int) -}}
    {{- $connectionString = printf "%s%s-mongodb-%d.%s-mongodb-headless.%s.svc.cluster.local," $connectionString $.Release.Name $i $.Release.Name $.Release.Namespace -}}
  {{- end -}}
  {{- $connectionString = printf "%s" (trimSuffix "," $connectionString) -}}
  {{- printf "%s/?replicaSet=%s" $connectionString .Values.mongodb.replicaSetName -}}
{{- end -}}
{{- end -}}

{{/*
MongoDB hostname
*/}}
{{- define "mongodb.hostname" -}}
{{- if .Values.mckMongodb.migrated }}
  {{- printf "%s" "mongodb-replica-set-svc" }}
{{- else -}}
  {{- if eq .Values.mongodb.architecture "standalone" }}
  {{- printf "%s" "mongodb" }}
  {{- else }}
  {{- printf "%s" "mongodb-headless" }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Dragonfly Service name
*/}}
{{- define "dragonfly.servicename" -}}
{{- if .Values.dragonfly.enabled }}
{{- include "dragonfly.fullname" .Subcharts.dragonfly }}
{{- else }}
{{- .Values.externalServices.redisHost }}
{{- end }}
{{- end }}

{{/*
Dragonfly Service port
*/}}
{{- define "dragonfly.serviceport" -}}
{{- if .Values.dragonfly.enabled }}
{{- .Values.dragonfly.service.port }}
{{- else }}
{{- .Values.externalServices.redisPort }}
{{- end }}
{{- end }}

{{/*
clientConfiguration string compose
*/}}
{{- define "clearml.clientConfiguration" -}}
{{- $clientConfiguration := "" }}
{{- if and (.Values.clearml.clientConfigurationApiUrl) .Values.clearml.clientConfigurationFilesUrl }}
{{- $clientConfiguration = printf "%s%s%s%s%s" "{\"apiServer\":\"" .Values.clearml.clientConfigurationApiUrl "\",\"filesServer\":\"" .Values.clearml.clientConfigurationFilesUrl "\"}" }}
{{- else if .Values.clearml.clientConfigurationApiUrl }}
{{- $clientConfiguration = printf "%s%s%s" "{\"apiServer\":\"" .Values.clearml.clientConfigurationApiUrl "\"}" }}
{{- else if .Values.clearml.clientConfigurationFilesUrl }}
{{- $clientConfiguration = printf "%s%s%s" "{\"filesServer\":\"" .Values.clearml.clientConfigurationFilesUrl "\"}" }}
{{- end }}
{{- $clientConfiguration }}
{{- end }}
