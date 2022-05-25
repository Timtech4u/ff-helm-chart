package app

import apiV1 "k8s.io/api/core/v1"
import networkV1 "k8s.io/api/networking/v1"
import resource "k8s.io/apimachinery/pkg/api/resource"

#App : {
	annotations?: [string]: string
	fullnameOverride?: string
	replicaCount: int | *1
	labels: [string]: string

	image: {
		url: string
		pullPolicy: apiV1.#enumPullPolicy | *"IfNotPresent"
		command?: [string, ...]
		args?: [string, ...]
	}

	imagePullSecrets: [apiV1.#LocalObjectReference, ...] | *[
		{
			name: "regsec"
		}
	]

	ports?: [{
		name: string
		"number": int
	}, ...]

	serviceAccount: {
		create: bool | *false
		annotations?: [string]: string
		name?: string
	}

	podAnnotations: [string]: string

	podSecurityContext?: apiV1.#PodSecurityContext

	securityContext?: apiV1.#SecurityContext

	service: {
		type: apiV1.#enumServiceType | *"ClusterIP"
		exported: bool | *false
	}

	ingress: {
		enabled:   bool | *false
		className: string | *""
		annotations: [string]: string | *{
			"cert-manager.io/cluster-issuer": "letsencrypt-prod"
			"nginx.ingress.kubernetes.io/service-upstream": "true"
		}
		hosts: [{
			host: string | *"chart-example.local"
			paths: [{
				// -- Path to be exposed
				path:     string | *"/"
				pathType: networkV1.#enumPathType | *"ImplementationSpecific"
				// -- Target exposed port
				port: int | *80
			}, ...]
		}, ...]
		tls: [networkV1.#IngressTLS, ...] | *[]
	}

	resources: {
		limits: {
			cpu: resource.#Quantity | *"200m"
			memory: resource.#Quantity | *"265Mi"
		}
		requests: {
			cpu: resource.#Quantity | *"100m"
			memory: resource.#Quantity | *"128Mi"
		}
	}

	autoscaling: {
		enabled: bool | *false
		minReplicas: int | *1
		maxReplicas: int | *5
		targetCPUUtilizationPercentage?: int | *80
		targetMemoryUtilizationPercentage?: int
	}

	nodeSelector: [string]: string | *{}

	tolerations: [apiV1.#Toleration, ...] | *[]

	affinity: apiV1.#Affinity | *{}

	secrets: {
		name: string
		backend: string
		projectId: string
		data: [{
			key: string
			name: string
		}, ...]
	} | *{}

	terminationGracePeriodSeconds: int | *30

	probes: {
		liveness: {
			// -- Enable liveness probes
			enabled: bool | *false
			// -- Liveness probe method to be used. Only 3 valid options: http, tcp and command
			mode: *"http" | "tcp" | "command"
			if mode == "http" {
				// -- livenes probes target path
				path: string | *"/"
				// -- liveness probes target port
				port: int | *80
			}
			if mode == "tcp" {
				// -- liveness probes target port
				port: int | *80
			}
			if mode == "command" {
				// -- liveness probes command (for command mode)
				command?: [string, ...]
			}
			// -- Number of seconds after the container has started before liveness or readiness probes are initiated.
			initialDelaySeconds: int | *0
			// -- How often (in seconds) to perform the probe.
			periodSeconds: int | *10
		}
		readiness?: {
			// -- Enable readiness probes
			enabled: bool | false
			// -- Readiness probe method to be used. Only 3 valid options: http, tcp and command
			mode: *"http" | "tcp" | "command"
			if mode == "http" {
				// -- Readiness probes target path
				path: string | "/"
				// -- Readiness probes target port
				port: int | 80
			}
			if mode == "tcp" {
				// -- Readiness probes target port
				port: int | 80
			}
			if mode == "command" {
				// -- Readiness probes command (for command mode)
				command: [string, ...]
			}
			// -- Number of seconds after the container has started before probes are initiated.
			initialDelaySeconds: int | *0
			// -- How often (in seconds) to perform the probe.
			periodSeconds: int | *10
		}
	}

	backendConfig: {
		// -- Enable Backend Config
		enabled: bool | *false
		// -- Port to be used on Backend Config
		port: int | *3000
	}

	// -- This new params would disable our changes by default.
	disableSuffix: bool | *false

	// -- Pull sensitive data from Secret Manager into environment variable
	// ```
	// - key: the secret key on Secret Manager
	//   name: name of environment variables
	// ```
	extraSecrets: [{
		key: string
		name: string
	}, ...] | *[]

	// -- Override secret key from Google Secret Manager
	overrideSecretKey?: null

	extraEnv: [apiV1.#EnvVar, ...] | *[]

	secretProject?: string

	volumeMounts?: [apiV1.#VolumeMount, ...]
	volumes?: [apiV1.#Volume, ...]

	linkerd?: [string]: string
}