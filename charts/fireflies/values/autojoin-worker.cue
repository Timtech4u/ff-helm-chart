package fireflies

"autojoin-worker": {
	fullnameOverride: "autojoin-worker"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/autojoin-worker-ff/autojoin-worker-ff"
	ports: [{
		name:   "http"
		number: 7400
	}]
	resources: {
		limits: {
			cpu:    "1200m"
			memory: "1Gi"
		}
		requests: {
			cpu:    "790m"
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
		name:  "googleProjectId"
		value: _#config.googleProjectId
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
		name:  "SERVER_PORT"
		value: "SERVER_PORT"
	}, {
		name:  "SERVER_IP"
		value: "SERVER_IP"
	}, {
		name:  "DEBUG_AUTOJOIN"
		value: "DEBUG_AUTOJOIN"
	}, {
		name:  "QUEUE"
		value: "QUEUE"
	}, {
		name:  "AUTO_JOIN_WORKER_QUEUE"
		value: "AUTO_JOIN_WORKER_QUEUE"
	}, {
		name:  "GCLOUD_PROJECT"
		value: _#config.googleProjectId
	}, {
		name:  "TZ"
		value: "TZ"
	}, {
		name:  "CALL_JOIN_URL"
		value: "http://call-join.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "CJ_URL"
		value: "http://call-join.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "HIDE_AUTOCONFIRM"
		value: "HIDE_AUTOCONFIRM"
	}, {
		name:  "autoJoinQueueTopic"
		value: "autojoin-queue"
	}, {
		name:  "PUB_SUB_SUBSCRIPTION"
		value: "autojoin-queue-sub"
	}, {
		name:  "REAUTH_SERVICE_URL"
		value: "https://auth-ff.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "callJoinQueueTopic"
		value: "call-join-queue"
	}, {
		name:  "EVENT_STREAM_TOPIC"
		value: "autojoin-worker-ff-events"
	}, {
		name:  "USER_SERVICE_GRPC_URL"
		value: "user-service.production.svc.cluster.local:50051"
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
		name:  "USER_RPC_SERVER_ADDRESS"
		value: "user-service.production.svc.cluster.local:50051"
	}, {
		name: "SENTRY_DSN_URL"
		value: "https://cb8f7bb624784da4bd72ede8d5f0fbf4@o207331.ingest.sentry.io/1548795"
	}, {
		name: "CONCURRENT_MESSAGES"
		value: "10"
	}, {
		name: "REDIS_URL"
		value: "redis://redis-master.private.svc.cluster.local:6379"
	}, {
		name: "AUTOJOIN_JOB_MAX_SECONDS"
		value: "30"
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
		name: "OVERWRITE_CHANNEL_ID"
		key:  "OVERWRITE_CHANNEL_ID"
	}, {
		name: "REPORT_CHANNEL_ID"
		key:  "REPORT_CHANNEL_ID"
	}, {
		name: "SLACK_CHANNEL_ID"
		key:  "SLACK_CHANNEL_ID"
	}, {
		name: "OFFICE_CLIENT_ID"
		key:  "OFFICE_CLIENT_ID"
	}, {
		name: "OFFICE_CLIENT_SECRET"
		key:  "OFFICE_CLIENT_SECRET"
	}, {
		name: "TWILIO_ACCOUNT_SID"
		key:  "TWILIO_ACCOUNT_SID"
	}, {
		name: "TWILIO_AUTH_TOKEN"
		key:  "TWILIO_AUTH_TOKEN"
	}, {
		name: "SEGMENT_WRITE_KEY"
		key:  "SEGMENT_WRITE_KEY"
	}, {
		name: "QUEUE_PREFIX"
		key:  "QUEUE_PREFIX"
	}, {
		name: "GOOGLE_CLIENT_ID"
		key:  "GOOGLE_CLIENT_ID"
	}, {
		name: "GOOGLE_SECRET"
		key:  "GOOGLE_SECRET"
	}, {
		name: "OUTLOOK_CLIENT_ID"
		key:  "OUTLOOK_CLIENT_ID"
	}, {
		name: "OUTLOOK_SECRET"
		key:  "OUTLOOK_SECRET"
	}]
	terminationGracePeriodSeconds: 80
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "autojoin-worker-ff.firefliesapp.com"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     7400
			}]
		}]
		tls: [{
			hosts: [
				"autojoin-worker-ff.firefliesapp.com",
			]
			secretName: "autojoin-worker-prod-tls-secret"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    10
		maxReplicas:                    40
		targetCPUUtilizationPercentage: 50
	}
	labels: {
		app:        "autojoin-worker"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "autojoin-worker"
	}
}
