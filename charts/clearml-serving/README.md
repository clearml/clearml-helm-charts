# ClearML Kubernetes Serving

![Version: 1.6.0](https://img.shields.io/badge/Version-1.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.3.0](https://img.shields.io/badge/AppVersion-1.3.0-informational?style=flat-square)

ClearML Serving Helm Chart

**Homepage:** <https://clear.ml>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| filippo-clearml |  | <https://github.com/filippo-clearml> |

## Introduction

The **clearml-serving** is the Kubernetes serving for for [ClearML](https://github.com/clearml/clearml-serving).
It allows you to serve models on a Kubernetes cluster.

## Add to local Helm repository

To add this chart to your local Helm repository:

```
helm repo add clearml https://clearml.github.io/clearml-helm-charts
```

# Upgrading Chart

## Upgrades/ Values upgrades

Updating to latest version of this chart can be done in two steps:

```
helm repo update
helm upgrade clearml-serving clearml/clearml-serving
```

Changing values on existing installation can be done with:

```
helm upgrade clearml-serving clearml/clearml-serving --version <CURRENT CHART VERSION> -f custom_values.yaml
```

## Source Code

* <https://github.com/clearml/clearml-helm-charts>
* <https://github.com/clearml/clearml>

## Requirements

Kubernetes: `>= 1.21.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | kafka | 21.4.0 |
| https://grafana.github.io/helm-charts | grafana | 6.52.3 |
| https://prometheus-community.github.io/helm-charts | prometheus | 19.7.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clearml | object | `{"apiAccessKey":"ClearML API Access Key","apiHost":"http://clearml-server-apiserver:8008","apiSecretKey":"ClearML API Secret Key","defaultBaseServeUrl":"http://127.0.0.1:8080/serve","filesHost":"http://clearml-server-fileserver:8081","kafkaServeUrl":"","servingTaskId":"ClearML Serving Task ID","webHost":"http://clearml-server-webserver:80"}` | ClearMl generic configurations |
| clearml_serving_inference | object | `{"additionalConfigs":{},"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50},"existingAdditionalConfigsConfigMap":"","existingAdditionalConfigsSecret":"","extraEnvironment":[],"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-inference","tag":"1.3.0"},"ingress":{"annotations":{},"enabled":false,"hostName":"serving.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""},"nodeSelector":{},"pollFrequencyMinutes":"1.0","resources":{},"tolerations":[]}` | ClearML serving inference configurations |
| clearml_serving_inference.additionalConfigs | object | `{}` | files declared in this parameter will be mounted on internal folder /opt/clearml/config and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsSecret |
| clearml_serving_inference.affinity | object | `{}` | Affinity configuration |
| clearml_serving_inference.autoscaling | object | `{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50}` | Autoscaling configuration |
| clearml_serving_inference.existingAdditionalConfigsConfigMap | string | `""` | reference for files declared in existing ConfigMap will be mounted and read by pod (examples in values.yaml) |
| clearml_serving_inference.existingAdditionalConfigsSecret | string | `""` | reference for files declared in existing Secret will be mounted and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsConfigMap |
| clearml_serving_inference.extraEnvironment | list | `[]` | Extra environment variables |
| clearml_serving_inference.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_inference.image | object | `{"repository":"allegroai/clearml-serving-inference","tag":"1.3.0"}` | Container Image |
| clearml_serving_inference.ingress | object | `{"annotations":{},"enabled":false,"hostName":"serving.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""}` | Ingress exposing configurations |
| clearml_serving_inference.ingress.annotations | object | `{}` | Ingress annotations |
| clearml_serving_inference.ingress.enabled | bool | `false` | Enable/Disable ingress |
| clearml_serving_inference.ingress.hostName | string | `"serving.clearml.127-0-0-1.nip.io"` | Ingress hostname domain |
| clearml_serving_inference.ingress.ingressClassName | string | `""` | ClassName (must be defined if no default ingressClassName is available) |
| clearml_serving_inference.ingress.path | string | `"/"` | Ingress root path url |
| clearml_serving_inference.ingress.tlsSecretName | string | `""` | Reference to secret containing TLS certificate. If set, it enables HTTPS on ingress rule. |
| clearml_serving_inference.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_inference.pollFrequencyMinutes | string | `"1.0"` | Default polling frequency for finding new models |
| clearml_serving_inference.resources | object | `{}` | Pod resources definition |
| clearml_serving_inference.tolerations | list | `[]` | Tolerations configuration |
| clearml_serving_statistics | object | `{"additionalConfigs":{},"affinity":{},"enabled":true,"existingAdditionalConfigsConfigMap":"","existingAdditionalConfigsSecret":"","extraEnvironment":[],"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-statistics","tag":"1.3.0"},"nodeSelector":{},"pollFrequencyMinutes":"1.0","resources":{},"tolerations":[]}` | ClearML serving statistics configurations |
| clearml_serving_statistics.additionalConfigs | object | `{}` | files declared in this parameter will be mounted on internal folder /opt/clearml/config and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsSecret |
| clearml_serving_statistics.affinity | object | `{}` | Affinity configuration |
| clearml_serving_statistics.enabled | bool | `true` | Enable ClearML Serving Statistics |
| clearml_serving_statistics.existingAdditionalConfigsConfigMap | string | `""` | reference for files declared in existing ConfigMap will be mounted and read by pod (examples in values.yaml) |
| clearml_serving_statistics.existingAdditionalConfigsSecret | string | `""` | reference for files declared in existing Secret will be mounted and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsConfigMap |
| clearml_serving_statistics.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_statistics.image | object | `{"repository":"allegroai/clearml-serving-statistics","tag":"1.3.0"}` | Container Image |
| clearml_serving_statistics.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_statistics.pollFrequencyMinutes | string | `"1.0"` | Default polling frequency for finding new models |
| clearml_serving_statistics.resources | object | `{}` | Pod resources definition |
| clearml_serving_statistics.tolerations | list | `[]` | Tolerations configuration |
| clearml_serving_triton | object | `{"additionalConfigs":{},"affinity":{},"autoscaling":{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50},"enabled":true,"existingAdditionalConfigsConfigMap":"","existingAdditionalConfigsSecret":"","extraEnvironment":[],"extraPythonPackages":[],"image":{"repository":"allegroai/clearml-serving-triton","tag":"1.3.0"},"ingress":{"annotations":{},"enabled":false,"hostName":"serving-grpc.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""},"metricFrequencyMinutes":"1.0","nodeSelector":{},"pollFrequencyMinutes":"1.0","resources":{},"tolerations":[]}` | ClearML serving Triton configurations |
| clearml_serving_triton.additionalConfigs | object | `{}` | files declared in this parameter will be mounted on internal folder /opt/clearml/config and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsSecret |
| clearml_serving_triton.affinity | object | `{}` | Affinity configuration |
| clearml_serving_triton.autoscaling | object | `{"enabled":false,"maxReplicas":11,"minReplicas":1,"targetCPU":50,"targetMemory":50}` | Autoscaling configuration |
| clearml_serving_triton.enabled | bool | `true` | Triton pod creation enable/disable |
| clearml_serving_triton.existingAdditionalConfigsConfigMap | string | `""` | reference for files declared in existing ConfigMap will be mounted and read by pod (examples in values.yaml) |
| clearml_serving_triton.existingAdditionalConfigsSecret | string | `""` | reference for files declared in existing Secret will be mounted and read by pod (examples in values.yaml) if not overridden by existingAdditionalConfigsConfigMap |
| clearml_serving_triton.extraEnvironment | list | `[]` | Extra environment variables |
| clearml_serving_triton.extraPythonPackages | list | `[]` | Extra Python Packages to be installed in running pods |
| clearml_serving_triton.image | object | `{"repository":"allegroai/clearml-serving-triton","tag":"1.3.0"}` | Container Image |
| clearml_serving_triton.ingress | object | `{"annotations":{},"enabled":false,"hostName":"serving-grpc.clearml.127-0-0-1.nip.io","ingressClassName":"","path":"/","tlsSecretName":""}` | Ingress exposing configurations |
| clearml_serving_triton.ingress.annotations | object | `{}` | Ingress annotations |
| clearml_serving_triton.ingress.enabled | bool | `false` | Enable/Disable ingress |
| clearml_serving_triton.ingress.hostName | string | `"serving-grpc.clearml.127-0-0-1.nip.io"` | Ingress hostname domain |
| clearml_serving_triton.ingress.ingressClassName | string | `""` | ClassName (must be defined if no default ingressClassName is available) |
| clearml_serving_triton.ingress.path | string | `"/"` | Ingress root path url |
| clearml_serving_triton.ingress.tlsSecretName | string | `""` | Reference to secret containing TLS certificate. If set, it enables HTTPS on ingress rule. |
| clearml_serving_triton.metricFrequencyMinutes | string | `"1.0"` | Triton metric reporting update frequency in minutes |
| clearml_serving_triton.nodeSelector | object | `{}` | Node Selector configuration |
| clearml_serving_triton.pollFrequencyMinutes | string | `"1.0"` | Triton model update frequency in minutes |
| clearml_serving_triton.resources | object | `{}` | Pod resources definition |
| clearml_serving_triton.tolerations | list | `[]` | Tolerations configuration |
| grafana | object | `{"adminPassword":"clearml","adminUser":"admin","datasources":{"datasources.yaml":{"apiVersion":1,"datasources":[{"access":"proxy","isDefault":true,"name":"Prometheus","type":"prometheus","url":"http://{{ .Release.Name }}-prometheus-server"}]}},"enabled":true}` | Configuration from https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml |
| imageCredentials | object | `{"email":"someone@host.com","enabled":false,"existingSecret":"","password":"pwd","registry":"docker.io","username":"someone"}` | Private image registry configuration |
| imageCredentials.email | string | `"someone@host.com"` | Email |
| imageCredentials.enabled | bool | `false` | Use private authentication mode |
| imageCredentials.existingSecret | string | `""` | If this is set, chart will not generate a secret but will use what is defined here |
| imageCredentials.password | string | `"pwd"` | Registry password |
| imageCredentials.registry | string | `"docker.io"` | Registry name |
| imageCredentials.username | string | `"someone"` | Registry username |
| kafka | object | `{"enabled":true}` | Configuration from https://github.com/bitnami/charts/blob/main/bitnami/kafka/values.yaml |
| prometheus | object | `{"enabled":true,"extraScrapeConfigs":"- job_name: \"{{ .Release.Name }}-stats\"\n  static_configs:\n    - targets:\n      - \"{{ .Release.Name }}-statistics:9999\"\n","kube-state-metrics":{"enabled":false},"prometheus-node-exporter":{"enabled":false},"prometheus-pushgateway":{"enabled":false},"serverFiles":{"prometheus.yml":{"scrape_configs":[{"job_name":"prometheus","static_configs":[{"targets":["localhost:9090"]}]}]}}}` | Configuration from https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/values.yaml |
