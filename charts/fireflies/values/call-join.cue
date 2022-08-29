package fireflies

"call-join": {
	fullnameOverride: "call-join"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/call-join-ff/call-join-ff"
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "550m"
			memory: "1.5Gi"
		}
		requests: {
			cpu:    "500m"
			memory: "1.4Gi"
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
		name:  "K8S_RANCHER_TOPIC"
		value: "k8s-join-queue"
	}, {
		name:  "K8S_POD_TOPIC"
		value: "k8s-join-queue"
	}, {
		name:  "RECUR_QUEUE_TOPIC"
		value: "recur-queue"
	}, {
		name:  "DEFAULT_DUP_CACHE_TTL"
		value: "1200"
	}, {
		name:  "MAX_CALL_JOIN_MESSAGES"
		value: "20"
	}, {
		name:  "BOT_FF_QUEUE_PREFIX"
		value: "deprecated-queue"
	}, {
		name:  "PUPPET_FF_QUEUE_PREFIX"
		value: "deprecated-queue"
	}, {
		name:  "PUPPET_V2_GOOGLE_PROJECT_ID"
		value: _#config.googleProjectId
	}, {
		name:  "PUPPET_V2_PUB_SUB_TOPIC"
		value: "puppet-queue"
	}, {
		name:  "VP_WATCH_STUCK_JOBS"
		value: "voice-puppet-stuck-job-watch-recovery"
	}, {
		name:  "PUPPET_DEADLINE_SECONDS"
		value: "14400"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "AUTO_JOIN_WORKER_QUEUE"
		value: "autojoin-worker-ff-queue"
	}, {
		name:  "CALL_JOIN_ALERT_EXCHANGE"
		value: "call-join-alert-data-exchange"
	}, {
		name:  "CALL_JOIN_MEETING_EXCHANGE"
		value: "call-join-meeting-data-exchange"
	}, {
		name:  "CALL_JOIN_URL"
		value: "http://call-join.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "ELASTIC_SEARCH_URL"
		value: "https://es-dev.firefliesapp.com"
	}, {
		// to be replaced with internal endpoint
		name:  "QUEUE_PREFIX"
		value: "call-join-queue"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		// to be replaced with internal endpoint
		name:  "PORT"
		value: "3000"
	}, {
		name:  "PUPPET_V2_BUCKET"
		value: "rtmp-server-ff"
	}, {
		name:  "PUPPET_V2_AWS_REGION"
		value: "us-east-1"
	}, {
		name:  "PUPPET_V2_BRIDGE_FF_URL"
		value: "https://bridge-ff.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "PUPPET_V2_TAKE_SCREENSHOTS"
		value: "true"
	}, {
		name:  "PUPPET_V2_UPLOAD_HTML"
		value: "true"
	}, {
		name:  "AUDIO_SERVICE"
		value: "http://audio.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "PUB_SUB_SUBSCRIPTION"
		value: "call-join-queue-sub"
	}, {
		name:  "googleProjectId"
		value: _#config.googleProjectId
	}, {
		name:  "MEDIASTORAGE_BASEURL"
		value: "media-storage.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "PUPPET_USE_PROXY"
		value: "true"
	}, {
		name:  "PUPPET_CALL_JOIN_URL"
		value: "http://call-join.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "EVENT_STREAM_TOPIC"
		value: "call-join-ff-events"
	}, {
		name:  "PUPPET_V2_EVENT_STREAM_TOPIC"
		value: "puppet-runner-events"
	}, {
		name:  "CDN_URL"
		value: "https://cdn.fireflies.ai"
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
		name:  "DATABASE_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(PARSE_USERNAME):$(PARSE_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name:  "PUPPET_REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name:  "USER_SERVICE_GRPC_ENDPOINT"
		value: "user-service.private.svc.cluster.local:50051"
	}, {
		name:  "CALL_JOIN_SERVICE_NAME"
		value: "call-join"
	}, {
		name:  "USER_RPC_ENABLE_INSECURE"
		value: "enabled"
	}, {
		name:  "PUPPET_DESKTOP_IMAGE"
		value: "ghcr.io/firefliesai/puppet-desktop/puppet-desktop:90d12c2e"
	}, {
		name:  "PUPPET_IMAGE"
		value: "ghcr.io/firefliesai/puppet-runner/puppet-runner:6c96905f"
	}, {
		name: "K8S_PUPPET_DISPATCH_STRING"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "K8S_PUPPET_DISPATCH_STRING"
		}
	}, {
		name: "BASIC_AUTH_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "BASIC_AUTH_PASSWORD"
		}
	}, {
		name: "BASIC_AUTH_USER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "BASIC_AUTH_USER"
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
		name: "GOOGLE_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GOOGLE_SECRET"
		}
	}, {
		name: "GQL_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_ACCESS_TOKEN"
		}
	}, {
		name: "MONGO_DB_NAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "MONGO_DB_NAME"
		}
	}, {
		name: "OAUTH_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OAUTH_CLIENT_ID"
		}
	}, {
		name: "OAUTH_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OAUTH_CLIENT_SECRET"
		}
	}, {
		name: "OAUTH_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OAUTH_SECRET"
		}
	}, {
		name: "OUTLOOK_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OUTLOOK_CLIENT_ID"
		}
	}, {
		name: "OUTLOOK_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OUTLOOK_SECRET"
		}
	}, {
		name: "SEGMENT_WRITE_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SEGMENT_WRITE_KEY"
		}
	}, {
		name: "SERVER_IP"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SERVER_IP"
		}
	}, {
		name: "SERVER_PORT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SERVER_PORT"
		}
	}, {
		name: "TWILIO_ACCOUNT_SID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "TWILIO_ACCOUNT_SID"
		}
	}, {
		name: "TWILIO_AUTH_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "TWILIO_AUTH_TOKEN"
		}
	}, {
		name: "PUPPET_MEETING_QUEUE"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_MEETING_QUEUE"
		}
	}, {
		name: "PUPPET_V2_CAPTCHA_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_V2_CAPTCHA_API_KEY"
		}
	}, {
		name: "PUPPET_V2_ANTICAPTCHA_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_V2_ANTICAPTCHA_API_KEY"
		}
	}, {
		name: "PUPPET_V2_AWS_ACCESS_KEY_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_V2_AWS_ACCESS_KEY_ID"
		}
	}, {
		name: "PUPPET_V2_AWS_SECRET_ACCESS_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_V2_AWS_SECRET_ACCESS_KEY"
		}
	}, {
		name: "AUDIO_SERVICE_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUDIO_SERVICE_TOKEN"
		}
	}, {
		name: "PUPPET_PROXY_SERVER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_PROXY_SERVER"
		}
	}, {
		name: "PUPPET_PROXY_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_PROXY_PASSWORD"
		}
	}, {
		name: "PUPPET_PROXY_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PUPPET_PROXY_USERNAME"
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
		name: "GROWTHBOOK_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GROWTHBOOK_API_KEY"
		}
	}]
	extraSecrets: []
	terminationGracePeriodSeconds: 80
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "call-join.firefliesapp.com"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"call-join.firefliesapp.com",
			]
			secretName: "call-join-prod-tls-secret"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    12
		maxReplicas:                    40
		targetCPUUtilizationPercentage: 40
	}
	labels: {
		app:        "call-join-ff"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "calendar-ff"
	}
}
