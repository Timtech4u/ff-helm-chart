package fireflies

dashboard: {
	image: url: "ghcr.io/firefliesai/use-notes/use-notes"
	fullnameOverride: "dashboard"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "1000m"
			memory: "1Gi"
		}
		requests: {
			cpu:    "200m"
			memory: "500Mi"
		}
	}
	extraEnv: [{
		name:  "PORT"
		value: "3000"
	}, {
		name:  "NEW_RELIC_APP_NAME"
		value: "private-cloud-dashboard"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "APOLLO_FF_URL"
		value: "https://apollo-ff.fireflies.dev"
	}, {
		name:  "AUDIO_WORKER_URL"
		value: "https://audio-ff.fireflies.dev"
	}, {
		name:  "CALL_JOIN_SERVICE"
		value: "call-join.private.svc.cluster.local:3000"
	}, {
		name:  "DOWNLOAD_SERVER"
		value: "https://download.fireflies.dev"
	}, {
		name:  "ELASTIC_SEARCH_URL"
		value: "https://es-dev.firefliesapp.com"
	}, {
		name:  "GLOVE_SERVICE_URI"
		value: "https://glove-ff.fireflies.dev"
	}, {
		name:  "HUBSPOT_APP_ID"
		value: "226796"
	}, {
		name:  "INTEGRATION_BACKEND_URL"
		value: "https://integration.fireflies.dev/v1"
	}, {
		name:  "PAYMENTS_FF_URL"
		value: "https://payments-ff.fireflies.dev"
	}, {
		name:  "PAYMENTS_FF_USERNAME"
		value: "payment"
	}, {
		name:  "REACT_APP_STRIPE_ENV"
		value: "staging_test"
	}, {
		name:  "STRIPE_ENV"
		value: "staging_test"
	}, {
		name:  "WORKPLACE_BACKEND_BASE_URL"
		value: "https://integration.fireflies.dev"
	}, {
		name:  "ROOT_URL"
		value: "https://private.fireflies.dev"
	}, {
		name:  "GQL_URL"
		value: "https://bot.private.fireflies.dev/graphql"
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
	}, {
		name:  "ANALYTICS_URL"
		value: "https://analytics.firefliesapp.com/v1/analytics"
	}, {
		name:  "ANALYTICS_USERNAME"
		value: "analytics-ff"
	}, {
		name:  "TZ"
		value: "America/New_York"
	}, {
		name:  "USER_SERVICE_API_URL"
		value: "https://user-service.private.fireflies.dev/"
	}, {
		name:  "USER_SERVICE_GOOGLE_AUTH_ENDPOINT"
		value: "auth/signup/google"
	}, {
		name:  "USER_SERVICE_OFFICE_AUTH_ENDPOINT"
		value: "auth/signup/outlook"
	}, {
		name:  "USER_SERVICE_GRPC_ENDPOINT"
		value: "user-service.private.svc.cluster.local:50051"
	}, {
		name:  "USE_NOTES_SERVICE_NAME"
		value: "use-notes-ff"
	}, {
		name:  "USER_SERVICE_GRPC_ENABLE_INSECURE"
		value: "enabled"
	}, {
		name: "SERVICE_NAME"
		value: "dashboard"
	}, {
		name: "IS_DEV"
		value: "true"
	}, {
		name: "APOLLO_GRAPH_REF"
		value: "ff-federated-graph@staging"
	}]
	extraSecrets: [{
		name: "ADMIN_MEETING_NOTE_EDIT"
		key:  "ADMIN_MEETING_NOTE_EDIT"
	}, {
		name: "AUDIO_WORKER_AUTH"
		key:  "AUDIO_WORKER_AUTH"
	}, {
		name: "ELASTIC_SEARCH_AUTH"
		key:  "ELASTIC_SEARCH_AUTH"
	}, {
		name: "GOOGLE_CLIENT_ID"
		key:  "GOOGLE_CLIENT_ID"
	}, {
		name: "GQL_ACCESS_TOKEN"
		key:  "GQL_ACCESS_TOKEN"
	}, {
		name: "IMPERSONATE_ADMIN_KEY"
		key:  "IMPERSONATE_ADMIN_KEY"
	}, {
		name: "PAYMENTS_FF_PASSWORD"
		key:  "PAYMENTS_FF_PASSWORD"
	}, {
		name: "REACT_APP_SENTRY_DNS_SERVER"
		key:  "REACT_APP_SENTRY_DNS_SERVER"
	}, {
		name: "REACT_APP_STRIPE_PUBLIC_KEY"
		key:  "REACT_APP_STRIPE_PUBLIC_KEY"
	}, {
		name: "S3_USE_NOTES_ACCESS"
		key:  "S3_USE_NOTES_ACCESS"
	}, {
		name: "SENDGRID_API_KEY"
		key:  "SENDGRID_API_KEY"
	}, {
		name: "SENTRY_DSN_SERVER"
		key:  "SENTRY_DSN_SERVER"
	}, {
		name: "STRIPE_SECRET_KEY"
		key:  "STRIPE_SECRET_KEY"
	}, {
		name: "ZAPIER_INVITE"
		key:  "ZAPIER_INVITE"
	}, {
		name: "ZENDESK_VISITOR_AUTH"
		key:  "ZENDESK_VISITOR_AUTH"
	}, {
		name: "JWT_SECRET_KEY"
		key:  "JWT_SECRET_KEY"
	}, {
		name: "SEGMENT_WRITE_KEY"
		key:  "SEGMENT_WRITE_KEY"
	}, {
		name: "AZURE_CLIENT_ID"
		key:  "AZURE_CLIENT_ID"
	}, {
		name: "OFFICE_CLIENT_ID"
		key:  "OFFICE_CLIENT_ID"
	}, {
		name: "OFFICE_CLIENT_SECRET"
		key:  "OFFICE_CLIENT_SECRET"
	}, {
		name: "ANALYTICS_PASSWORD"
		key:  "ANALYTICS_PASSWORD"
	}, {
		name: "GOOGLE_SECRET"
		key:  "GOOGLE_SECRET"
	}, {
		name: "APOLLO_KEY"
		key: "APOLLO_KEY"
	}]
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"private.fireflies.dev",
			]
			secretName: "private-fireflies-dev-tls"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    3
		maxReplicas:                    15
		targetCPUUtilizationPercentage: 70
	}
	labels: {
		app:        "use-notes"
		owner:      "dashboard"
		costcenter: "dashboard"
		purpose:    "on-prem"
		component:  "dashboard"
	}
}
