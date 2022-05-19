# app

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A basic helm chart for deploying application on Fireflies

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Auto Scaling |
| autoscaling.maxReplicas | int | `5` | Auto scaling maximum number of pod |
| autoscaling.minReplicas | int | `1` | Auto scaling minimum number of pod |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Metrics to be used for deciding whether the pod should be upscaled or not. |
| backendConfig.enabled | bool | `false` | Enable Backend Config |
| backendConfig.port | int | `3000` | Port to be used on Backend Config |
| disableSuffix | bool | `true` | This new params would disable our changes by default. |
| extraSecrets | list | `[]` | Pull sensitive data from Secret Manager into environment variable ``` - key: the secret key on Secret Manager   name: name of environment variables ``` |
| image.args | list | `[]` | args to be used with command |
| image.command | list | `[]` | command to be used |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.url | string | `"nginx:latest"` | Full image address |
| imagePullSecrets[0] | object | `{"name":"regsec"}` | Secret to pull image |
| ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-prod"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/service-upstream" | string | `"true"` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` | Enable ingress creation |
| ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific","port":80}]}` | Public endpoint to access the service |
| ingress.hosts[0].paths[0] | object | `{"path":"/","pathType":"ImplementationSpecific","port":80}` | Path to be exposed |
| ingress.hosts[0].paths[0].port | int | `80` | Target exposed port |
| ingress.tls | list | `[]` |  |
| labels | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| overrideSecretNamespace | string | `nil` | Override secret key namespace |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| ports | list | `[]` | list of ports to be exposed |
| probes.liveness.command | list | `[]` | liveness probes command (for command mode) |
| probes.liveness.enabled | bool | `false` | Enable liveness probes |
| probes.liveness.initialDelaySeconds | int | `0` | Number of seconds after the container has started before liveness or readiness probes are initiated. |
| probes.liveness.mode | string | `"http"` | Liveness probe method to be used. Only 3 valid options: http, tcp and command |
| probes.liveness.path | string | `"/"` | livenes probes target path |
| probes.liveness.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| probes.liveness.port | int | `80` | liveness probes target port |
| probes.readiness.command | list | `[]` | Readiness probes command (for command mode) |
| probes.readiness.enabled | bool | `false` | Enable readiness probes |
| probes.readiness.initialDelaySeconds | int | `0` | Number of seconds after the container has started before probes are initiated. |
| probes.readiness.mode | string | `"http"` | Readiness probe method to be used. Only 3 valid options: http, tcp and command |
| probes.readiness.path | string | `"/"` | Readiness probes target path |
| probes.readiness.periodSeconds | int | `10` | How often (in seconds) to perform the probe. |
| probes.readiness.port | int | `80` | Readiness probes target port |
| replicaCount | int | `1` | The desired number of pod |
| resources.limits.cpu | string | `"200m"` | Configure CPU limits for the pod. |
| resources.limits.memory | string | `"256Mi"` | Configure Memory limit for the pod. This is the hard limit resources, so whenever your application uses more than the limit, it could throw OOM error. |
| resources.requests.cpu | string | `"100m"` | Configure CPU request for the pod. |
| resources.requests.memory | string | `"128Mi"` | Configure Memory request for the pod. |
| secrets | object | `{}` | External secret to be pulled and used for the deployment. Use this for non standard secret. For standard environment variables, please check `extraSecret` variable ``` name: secret-name backend: gcpSecretsManager projectId: fireflies-ai values: - key: key-on-secret-manager   name: secret-data-name ``` |
| securityContext | object | `{}` |  |
| service.exported | bool | `false` | Multicluster exposed service. Set this to `true` to expose this service to the multicluster communication link |
| service.type | string | `"ClusterIP"` | Kubernetes Service type to be created. Use this default value to expose the service via ingress-nginx |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| terminationGracePeriodSeconds | int | `30` | Configure how long the termination period (t) |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.10.0](https://github.com/norwoodj/helm-docs/releases/v1.10.0)
