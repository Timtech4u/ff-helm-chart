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
	volumes: [{
		name: "google-cloud-key"
		secret: secretName: "pubsub-key"
	}]
	volumeMounts: [{
		name:      "google-cloud-key"
		mountPath: "/var/secrets/google"
	}]
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
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
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
		name:  "SERVICE_NAME"
		value: "dashboard"
	}, {
		name:  "IS_DEV"
		value: "true"
	}, {
		name:  "APOLLO_GRAPH_REF"
		value: "ff-federated-graph@staging"
	}, {
		name:  "GOOGLE_PROJECT_ID"
		value: "ff-private-cloud"
	}, {
		name: "ADMIN_MEETING_NOTE_EDIT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "K8S_PUPPET_DISPATCH_STRING"
		}
	}, {
		name: "APOLLO_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "APOLLO_KEY"
		}
	}, {
		name: "AUDIO_WORKER_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUDIO_WORKER_AUTH"
		}
	}, {
		name: "CDN_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "CDN_URL"
		}
	}, {
		name: "ELASTIC_SEARCH_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ELASTIC_SEARCH_AUTH"
		}
	}, {
		name: "GOOGLE_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GOOGLE_CLIENT_ID"
		}
	}, {
		name: "GQL_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_ACCESS_TOKEN"
		}
	}, {
		name: "IMPERSONATE_ADMIN_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "IMPERSONATE_ADMIN_KEY"
		}
	}, {
		name: "PAYMENTS_FF_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PAYMENTS_FF_PASSWORD"
		}
	}, {
		name: "REACT_APP_SENTRY_DNS_SERVER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "REACT_APP_SENTRY_DNS_SERVER"
		}
	}, {
		name: "REACT_APP_STRIPE_PUBLIC_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "REACT_APP_STRIPE_PUBLIC_KEY"
		}
	}, {
		name: "S3_USE_NOTES_ACCESS"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "S3_USE_NOTES_ACCESS"
		}
	}, {
		name: "SENDGRID_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SENDGRID_API_KEY"
		}
	}, {
		name: "SENTRY_DSN_SERVER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SENTRY_DSN_SERVER"
		}
	}, {
		name: "STRIPE_SECRET_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "STRIPE_SECRET_KEY"
		}
	}, {
		name: "ZAPIER_INVITE"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ZAPIER_INVITE"
		}
	}, {
		name: "ZENDESK_VISITOR_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ZENDESK_VISITOR_AUTH"
		}
	}, {
		name: "JWT_SECRET_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "JWT_SECRET_KEY"
		}
	}, {
		name: "SEGMENT_WRITE_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SEGMENT_WRITE_KEY"
		}
	}, {
		name: "AZURE_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AZURE_CLIENT_ID"
		}
	}, {
		name: "OFFICE_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_CLIENT_ID"
		}
	}, {
		name: "OFFICE_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_CLIENT_SECRET"
		}
	}, {
		name: "ANALYTICS_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ANALYTICS_PASSWORD"
		}
	}, {
		name: "GOOGLE_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GOOGLE_SECRET"
		}
	}, {
		name: "KEY_PAIR_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "KEY_PAIR_ID"
		}
	}, {
		name: "PRIVATE_KEY_STRING"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PRIVATE_KEY_STRING"
		}
	}, {
		name: "PUBLIC_KEY_STRING"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUBLIC_KEY_STRING"
		}
	}]
	extraSecrets: []
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
