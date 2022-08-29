package fireflies

download: {
	fullnameOverride: "download"
	secretProject:    _#config.googleProjectId
	image: url: "ghcr.io/firefliesai/download-ff/download-ff"
	ports: [{
		name:   "http"
		number: 3000
	}]
	extraEnv: [{
		name:  "DEBUG"
		value: "true"
	}, {
		name: "USE_NOTES_MONGO_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "password"
		}
	}, {
		name: "USE_NOTES_MONGO_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "username"
		}
	}, {
		name: "MONGO_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "username"
		}
	}, {
		name: "MONGO_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "password"
		}
	}, {
		name: "PARSE_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "username"
		}
	}, {
		name: "PARSE_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "password"
		}
	}, {
		name:  "PARSE_DB_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "USE_NOTES_MONGO_URI"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "DATABASE_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		name: "NODE_ENV"
		valueFrom: fieldRef: fieldPath: "metadata.namespace"
	}, {
		name:  "OTEL_EXPORTER_OTLP_ENDPOINT"
		value: "https://api.honeycomb.io"
	}, {
		name:  "OTEL_SERVICE_NAME"
		value: "download"
	}, {
		name:  "FIREFLIES_ORIGIN"
		value: "https://app.fireflies.dev"
	}, {
		name:  "AWS_BUCKET_REGION"
		value: "auto"
	}, {
		name:  "AWS_BUCKET_ID"
		value: "ff-private-download"
	}, {
		name: "AWS_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AWS_SECRET"
		}
	}, {
		name: "AWS_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AWS_KEY"
		}
	}, {
		name: "SENTRY_DSN_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SENTRY_DSN_URL"
		}
	}]
	extraSecrets: []
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "download.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "ImplementationSpecific"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"download.private.fireflies.dev",
			]
			secretName: "download-private-tls-secret"
		}]
	}
	resources: {
		limits: {
			cpu:    "600m"
			memory: "1200Mi"
		}
		requests: {
			cpu:    "500m"
			memory: "1000Mi"
		}
	}
	probes: {
		liveness: {
			enabled:             false
			mode:                "http"
			path:                "/health"
			port:                3000
			initialDelaySeconds: 0
			periodSeconds:       10
		}
		readiness: {
			enabled:             false
			mode:                "http"
			path:                "/health"
			port:                3000
			initialDelaySeconds: 0
			periodSeconds:       10
		}
	}
}
