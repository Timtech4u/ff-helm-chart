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
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "DATABASE_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "GQL_URL"
		value: "https://bot.firefliesapp.com/graphql"
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
	}]
	extraSecrets: [{
		name: "AWS_BUCKET_ID"
		key:  "AWS_BUCKET_ID"
	}, {
		name: "AWS_BUCKET_REGION"
		key:  "AWS_BUCKET_REGION"
	}, {
		name: "AWS_SECRET"
		key:  "AWS_SECRET"
	}, {
		name: "AWS_KEY"
		key:  "AWS_KEY"
	}, {
		name: "SENTRY_DSN_URL"
		key:  "SENTRY_DSN_URL"
	}, {
		name: "USE_NOTES_MONGO_USERNAME"
		key:  "USE_NOTES_MONGO_USERNAME"
	}, {
		name: "USE_NOTES_MONGO_PASSWORD"
		key:  "USE_NOTES_MONGO_PASSWORD"
	}, {
		name: "USE_NOTES_MONGO_URI"
		key:  "USE_NOTES_MONGO_URI"
	}, {
		name: "PARSE_DB_URL"
		key:  "mongo-database-uri"
	}, {
		name: "OTEL_EXPORTER_OTLP_HEADERS"
		key:  "OTEL_EXPORTER_OTLP_HEADERS"
	}]
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "download.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "ImplementationSpecific"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"download.fireflies.dev",
			]
			secretName: "download-tls-secret"
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
	nodeSelector: "fireflies.ai/app": "fireflies"
}
