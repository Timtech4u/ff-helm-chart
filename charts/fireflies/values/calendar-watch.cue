package fireflies

"calendar-watch": {
	fullnameOverride: "calendar-watch"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/calendar-watch/calendar-watch"
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "100m"
			memory: "1Gi"
		}
		requests: {
			cpu:    "90m"
			memory: "900Mi"
		}
	}
	volumes: [{
		name: "google-cloud-key"
		secret: secretName: "pubsub-key"
	}]
	volumeMounts: [{
		name:      "google-cloud-key"
		mountPath: "/var/secrets/google"
	}]
	extraEnv: [{
		name:  "CALENDAR_WATCH_SERVICE_NAME"
		value: "calendar-watch"
	}, {
		name:  "USER_SERVICE_GRPC_URL"
		value: "user-service.private.svc.cluster.local:50051"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		// to be replaced with internal endpoint
		name:  "autoJoinQueueTopic"
		value: "autojoin-queue"
	}, {
		name:  "USER_SERVICE_GRPC_URL"
		value: "user-service.private.svc.cluster.local:50051"
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
		name:  "USE_NOTES_MONGO_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "MONGO_USE_NOTES_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "MONGO_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(PARSE_USERNAME):$(PARSE_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}]
	extraSecrets: [{
		name: "GQL_ACCESS_TOKEN"
		key:  "GQL_ACCESS_TOKEN"
	}, {
		name: "OAUTH_CLIENT_ID"
		key:  "OAUTH_CLIENT_ID"
	}, {
		name: "OAUTH_CLIENT_SECRET"
		key:  "OAUTH_CLIENT_SECRET"
	}, {
		name: "RABBIT_MQ_URL"
		key:  "RABBIT_MQ_URL"
	}, {
		name: "GOOGLE_CLIENT_ID"
		key:  "GOOGLE_CLIENT_ID"
	}, {
		name: "GOOGLE_SECRET"
		key:  "GOOGLE_SECRET"
	}, {
		name: "SENTRY_DSN_URL"
		key:  "SENTRY_DSN_URL"
	}, {
		name: "BASIC_AUTH_USERNAME"
		key:  "BASIC_AUTH_USERNAME"
	}, {
		name: "BASIC_AUTH_PASSWORD"
		key:  "BASIC_AUTH_PASSWORD"
	}, {
		name: "OUTLOOK_CLIENT_ID"
		key:  "OUTLOOK_CLIENT_ID"
	}, {
		name: "OUTLOOK_SECRED"
		key:  "OUTLOOK_SECRED"
	}, {
		name: "OUTLOOK_TENANT"
		key:  "OUTLOOK_TENANT"
	}, {
		name: "OFFICE_CLIENT_ID"
		key:  "OFFICE_CLIENT_ID"
	}, {
		name: "OFFICE_CLIENT_SECRET"
		key:  "OFFICE_CLIENT_SECRET"
	}, {
		name: "USE_NOTES_MONGO_DB_NAME"
		key:  "USE_NOTES_MONGO_DB_NAME"
	}]
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "autojoin-ms.fireflies.ai"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"autojoin-ms.fireflies.ai",
			]
			secretName: "calendar-watch-prod-tls-secret"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    1
		maxReplicas:                    15
		targetCPUUtilizationPercentage: 80
	}

	labels: {
		app:        "calendar-watch"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "database-update-ff"
	}
}
