package fireflies

audio: {
	fullnameOverride: "audio"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/audio-ff/audio-ff"
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "1500m"
			memory: "3Gi"
		}
		requests: {
			cpu:    "1500m"
			memory: "3Gi"
		}
	}
	extraEnv: [{
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
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
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "MONGO_DB_NAME"
		value: "use-notes-0"
	}, {
		name:  "DASHBOARD_URL"
		value: "https://private.fireflies.dev"
	}, {
		name:  "UNSUBSCRIBE_ROOT_URL"
		value: "https://api.fireflies.dev"
	}, {
		name:  "DEFAULT_NUM_NOTES"
		value: "10"
	}, {
		name:  "GLOVE_SERVICE_TOKEN"
		value: ""
	}, {
		name:  "CRON_SERVICE_URL"
		value: "https://cron-master-ff.fireflies.dev"
	}, {
		name:  "RELOAD_FF_URL"
		value: "https://reload-ff.fireflies.dev"
	}, {
		name:  "MONITOR_NOTES_FF"
		value: "https://monitor-notes-ff.fireflies.dev"
	}, {
		name:  "ELASTIC_SEARCH_URL"
		value: "https://es-dev.firefliesapp.com"
	}, {
		name:  "CORE_URL"
		value: "https://core.fireflies.dev"
	}, {
		name:  "AUDIO_WORKER_QUEUE_PREFIX"
		value: "audio-ff"
	}, {
		name:  "RNN_URL"
		value: "https://predict-ff.fireflies.dev"
	}, {
		name:  "AUDIO_SERVICE_URL"
		value: "https://audio-service-ff.fireflies.dev"
	}, {
		name:  "GLOVE_SERVICE_FF"
		value: "https://glove-ff.fireflies.dev"
	}, {
		name:  "AWS_BUCKET"
		value: "rtmp-server-ff"
	}, {
		name:  "BOT_FIREFLIES_URL"
		value: "https://bot.private.fireflies.dev"
	}, {
		name:  "INTEGRATION_FF_URL"
		value: "https://integration.fireflies.dev"
	}, {
		name:  "API_FF_URL"
		value: "https://api.fireflies.dev"
	}, {
		name:  "EVENT_STREAM_TOPIC"
		value: "audio-ff-events"
	}, {
		name:  "FORMAT_LAMBDA_URL"
		value: "https://dwgritefml.execute-api.us-east-1.amazonaws.com/stage/captions"
	}, {
		name:  "GOOGLE_PROJECT_ID"
		value: _#config.googleProjectId
	}]
	extraSecrets: [{
		name: "REDIS_URL"
		key:  "REDIS_URL"
	}, {
		name: "REV_TOKEN"
		key:  "REV_TOKEN"
	}, {
		name: "SENDGRID_API_KEY"
		key:  "SENDGRID_API_KEY"
	}, {
		name: "GQL_AUTH"
		key:  "GQL_AUTH"
	}, {
		name: "CRON_SERVICE_TOKEN"
		key:  "CRON_SERVICE_TOKEN"
	}, {
		name: "AWS_ACCESS_KEY_ID"
		key:  "AWS_ACCESS_KEY_ID"
	}, {
		name: "AWS_SECRET_ACCESS_KEY"
		key:  "AWS_SECRET_ACCESS_KEY"
	}, {
		name: "ELASTIC_SEARCH_AUTH"
		key:  "ELASTIC_SEARCH_AUTH"
	}, {
		name: "WORKFLOW_SERVICE_AUTH"
		key:  "WORKFLOW_SERVICE_AUTH"
	}, {
		name: "ASSEMBLY_TOKEN"
		key:  "ASSEMBLY_TOKEN"
	}, {
		name: "API_KEY"
		key:  "API_KEY"
	}, {
		name: "OPEN_AI_API_KEY"
		key:  "OPEN_AI_API_KEY"
	}, {
		name: "SLACK_ACCESS_TOKEN"
		key:  "SLACK_ACCESS_TOKEN"
	}, {
		name: "SLACK_BOT_IMAGE"
		key:  "SLACK_BOT_IMAGE"
	}, {
		name: "API_FF_TOKEN"
		key:  "API_FF_TOKEN"
	}, {
		name: "WORD_CAB_API_KEY"
		key:  "WORD_CAB_API_KEY"
	}, {
		name: "K8S_PUPPET_DISPATCH_STRING"
		key:  "K8S_PUPPET_DISPATCH_STRING"
	}]
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "audio.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     9989
			}]
		}]
		tls: [{
			hosts: [
				"audio.private.fireflies.dev",
			]
			secretName: "audio-private-fireflies-dev-tls"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    3
		maxReplicas:                    15
		targetCPUUtilizationPercentage: 70
	}
}
