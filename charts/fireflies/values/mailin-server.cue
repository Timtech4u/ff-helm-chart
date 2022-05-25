package fireflies

"mailin-server": {
	fullnameOverride: "mailin-server"
	secretProject:    "ff-private-cloud"
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/mailin-server/mailin-server"
	ports: [{
		name:   "http"
		number: 3095
	}, {
		name:   "smtp"
		number: 25
	}]
	extraEnv: [{
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}]
	volumes: [{
		name: "google-cloud-key"
		secret: secretName: "pubsub-key"
	}]
	volumeMounts: [{
		name:      "google-cloud-key"
		mountPath: "/var/secrets/google"
	}]
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "mailin.firefliesapp.com"
			paths: [{
				path:     "/"
				pathType: "ImplementationSpecific"
				port:     3095
			}]
		}]
		tls: [{
			hosts: [
				"mailin.firefliesapp.com",
			]
			secretName: "mailin-server-tls-secret"
		}]
	}
	resources: {
		limits: {
			cpu:    "850m"
			memory: "3Gi"
		}
		requests: {
			cpu:    "800m"
			memory: "2900Mi"
		}
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    3
		maxReplicas:                    6
		targetCPUUtilizationPercentage: 80
	}
}
