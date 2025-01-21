# ClearML Helm Charts Installation guide

## Requirements

* Set up a Kubernetes Cluster - for setting up Kubernetes on various platforms refer to the Kubernetes [getting started guide](http://kubernetes.io/docs/getting-started-guides/).
  * Set up a single-node LOCAL Kubernetes on laptop/desktop - for setting up Kubernetes on your laptop/desktop, we suggest [kind](https://kind.sigs.k8s.io).
  * For **Kubernetes Tanzu users** - see [prerequisites](https://github.com/clearml/clearml-helm-charts/tree/main/platform-specific-configs/tanzu) 
  for setting up ClearML on a Tanzu cluster 
  * For **Kubernetes Openshift users** - see [prerequisites](https://github.com/clearml/clearml-helm-charts/tree/main/platform-specific-configs/openshift) 
  for setting up ClearML on an Openshift cluster, 

* Install Helm - Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes 
resources. To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

## Helm Charts Installation

### Helm Repo

```bash
$ helm repo add clearml https://clearml.github.io/clearml-helm-charts
$ helm repo update
```
### ClearML Server Ecosystem

```bash
$ helm install clearml clearml/clearml
```

### ClearML Agent

A ClearML Agent is always related to a ClearML server ecosystem (by default using the `app.clear.ml` hosted server, but 
can be on the same or different Kubernetes cluster or a single server installation).

In the ClearML UI, go to **Settings > Workspace** and click **Create New Credentials**. The dialog that pops up displays 
the new credentials.

In the Helm chart `install` command below:

* Set `ACCESSKEY` to the new credentials' `access_key` value 
* Set `SECRETKEY` to the new credentials' `secret_key` value
* Set `APISERVERURL` to the new credentials' `api_server` value
* Set `FILESSERVERURL` to the new credentials' `files_server` value
* Set `WEBSERVERURL` to the new credentials' `web_server` value

```bash
$ helm install clearml-agent clearml/clearml-agent --set clearml.agentk8sglueKey=ACCESSKEY --set clearml.agentk8sglueSecret=SECRETKEY --set agentk8sglue.apiServerUrlReference=APISERVERURL --set agentk8sglue.fileServerUrlReference=FILESERVERURL --set agentk8sglue.webServerUrlReference=WEBSERVERURL
```
