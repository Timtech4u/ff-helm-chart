# balloon

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for deploying Balloon pod

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | The way we schedule Balloon pod. By default it will spread the pod into each node, via antiaffinity |
| fullnameOverride | string | `""` | Override Full deployment name. Shouldn't be used unless you know what you want to achieve. |
| image.pullPolicy | string | `"IfNotPresent"` | What to do to pull image. |
| image.repository | string | `"us.gcr.io/google-containers/pause"` | Image to be used for balloon pod. This default image is the "default" do nothing pod. |
| image.tag | string | `"3.2"` | The default pause image version |
| imagePullSecrets | list | `[]` | imagePullSecrets if we want to pull the image from our registry |
| nameOverride | string | `""` | Override deployment name. Shouldn't be used unless you know what you want to achieve. |
| nodeSelector | object | `{}` | Node Selector to pick which nodes to be used for deploying balloon pod. In other word, which node that we will use for hold spare computes |
| podAnnotations | object | `{"linkerd.io/inject":"disabled"}` | Pod Annotations. The default value is to skip linkerd injection. |
| priority | int | `-10` | PriorityClass of the pod. It will determine the priority of the pod to be evicted. The default value here is the lowest value that GKE will consider to scale up but low enough to be evicted once our workload need. |
| replicaCount | int | `1` | Number of Balloon pod to be deployed. This number will determine how many compute spares that we will hold |
| resources.limits.cpu | string | `"500m"` | How many cpu limit that this balloon pod will use. |
| resources.limits.memory | string | `"512Mi"` | How many memory limit that this balloon pod will use. |
| resources.requests.cpu | string | `"250m"` | How many cpu request that this balloon pod will use. |
| resources.requests.memory | string | `"128Mi"` | How many memory request that this balloon pod will use. |
| tolerations | list | `[]` | Balloon pod schedule tolerations to enable the pod scheduled into some protected nodes (such as master). |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)
