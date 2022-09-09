package fireflies

"bot-fireflies": {
	fullnameOverride: "bot-fireflies"
	annotations: "reloader.stakater.com/auto": "true"
	secretProject: _#config.googleProjectId
	replicaCount:  1
	image: url: "ghcr.io/firefliesai/bot-fireflies/bot-fireflies"
	ports: [{
		name:   "http"
		number: 8001
	}]
	resources: {
		limits: {
			cpu:    "600m"
			memory: "2.5Gi"
		}
		requests: {
			cpu:    "590m"
			memory: "2.4Gi"
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
		name:  "mailinServerDevTopic"
		value: _#config.prefix+"mailin-server-queue"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "NODE_OPTIONS"
		value: "--max-old-space-size=2560"
	}, {
		name:  "EMAIL_TOPIC"
		value: _#config.prefix+"EMAIL_TOPIC_STAGING"
	}, {
		name:  "PARTICPANT_DISPATCH_QUEUE_PREFIX"
		value: "PARTICIPANT_JOB_QUEUE_STAGING"
	}, {
		name:  "COMPLIANCE_TOPIC"
		value: _#config.prefix+"COMPLIANCE_TOPIC_STAGING"
	}, {
		name:  "AUDIO_EDIT_SERVICE"
		value: "https://audio-edit.firefliesapp.com"
	}, {
		// to be replaced with internal endpoint
		name:  "AUDIO_FF_SERVICE"
		value: "https://audio-ff.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "AUTOJOIN_QUEUE_PREFIX"
		value: "ajworkersam"
	}, {
		name:  "BRIDGE_FF_URL"
		value: "https://bridge-ff.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "CALL_JOIN_ALERT_EXCHANGE"
		value: "call-join-alert-data-exchange-prod"
	}, {
		name:  "CALL_JOIN_MEETING_EXCHANGE"
		value: "call-join-meeting-data-exchange-prod"
	}, {
		name:  "CALL_JOIN_SERVICE"
		value: "http://call-join.private.svc.cluster.local:3000"
	}, {
		// to be replaced with internal endpoint
		name:  "DASHBOARD_URL"
		value: "https://private.fireflies.dev"
	}, {
		// to be replaced with internal endpoint
		name:  "callJoinQueueTopic"
		value: _#config.prefix+"call-join-queue"
	}, {
		name:  "DEBUG_RABBIT_MQ"
		value: "startWorkerDebug"
	}, {
		name:  "DOCKER_DEPLOY"
		value: "true"
	}, {
		name:  "ELASTIC_SEARCH_URL"
		value: "http://10.128.0.68:9200"
	}, {
		name:  "GCLOUD_PROJECT"
		value: _#config.googleProjectId
	}, {
		name:  "LOCAL_PORT"
		value: "8001"
	}, {
		name:  "MASTER_PHONE_NUMBERS"
		value: "true"
	}, {
		name:  "MASTER_REDIRECT"
		value: "true"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "NOTES_SERVICE_URL"
		value: "https://private.fireflies.dev"
	}, {
		name:  "PARSE_SERVER_URL"
		value: "https://db-ff.fireflies.ai/parse"
	}, {
		name:  "PAYMENTS_FF_BASE_URL"
		value: "https://payments-ff.fireflies.dev"
	}, {
		name:  "PROD_RABBIT_MQ"
		value: "startWorkerProductionOct"
	}, {
		name:  "REMOTE_EXEC_QUEUE"
		value: "remote-exec-ff-queue-prod"
	}, {
		name:  "SLACK_COMMUNICATION_SERVICE"
		value: "http://slack-comm.fireflies.dev"
	}, {
		name: "SLACK_REDIRECT_URI"
		// Can't be use internal endpoint since this being used by slack to hit bot ff
		value: "https://bot.private.fireflies.dev/slackAuthorize"
	}, {
		name:  "TEST_ENV_PUSH"
		value: "true"
	}, {
		name:  "TRANSCRIBE_FF_SERVICE"
		value: "https://transcribe-ff.firefliesapp.com"
	}, {
		name:  "TZ"
		value: "America/New_York"
	}, {
		name:  "WINSTON_SUBDOMAIN"
		value: "fireflies"
	}, {
		name:  "CALL_JOIN_QUEUE_PREFIX"
		value: "call-join-queue"
	}, {
		name:  "EMAIL_QUEUE_TOPIC"
		value: _#config.prefix+"email-queue"
	}, {
		name:  "EMAIL_SUBSCRIPTION"
		value: "email-queue-sub"
	}, {
		name:  "RECUR_QUEUE_TOPIC"
		value: _#config.prefix+"email-recurring"
	}, {
		name:  "RECUR_SUBSCRIPTION"
		value: "email-recurring-sub"
	}, {
		name:  "mailinServerDevSubscription"
		value: "mailin-server-queue-sub"
	}, {
		name:  "REAUTH_SERVICE_URL"
		value: "https://auth-ff.fireflies.dev"
	}, {
		name:  "GENERALSCHEDULER_TOPIC"
		value: _#config.prefix+"message-queue"
	}, {
		name:  "EVENT_STREAM_TOPIC"
		value: _#config.prefix+"bot-fireflies-events"
	}, {
		name:  "CALENDAR_QUEUE_TOPIC"
		value: _#config.prefix+"calendar-queue"
	}, {
		name:  "CALENDAR_SUBSCRIPTION"
		value: "calendar-queue-sub"
	}, {
		name:  "PARTICIPANT_DISPATCH_TOPIC"
		value: _#config.prefix+"participant-dispatch-queue"
	}, {
		name:  "DEBUG_AUTOJOIN"
		value: "true"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		// to be replaced with internal endpoint
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
		name: "PARSE_DB_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "username"
		}
	}, {
		name: "PARSE_DB_PASSWORD"
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
		value: "mongodb+srv://$(PARSE_DB_USERNAME):$(PARSE_DB_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "LOAD_BALANCER_SERVICE"
		value: "https://load-balancer.fireflies.dev"
	}, {
		name:  "PARTICIPANT_DISPATCH_URL"
		value: "http://participant-dispatch.private.svc.cluster.local:3000"
	}, {
		name:  "PUBSUB_AUTOJOIN_TOPIC"
		value: _#config.prefix+"autojoin-queue"
	}, {
		name:  "mailinServerSubscription"
		value: "mailin-server-queue-sub"
	}, {
		name:  "REPEAT_WATCH_TOPIC"
		value: _#config.prefix+"bot-ff-repeat-watch"
	}, {
		name:  "REPEAT_CALENDAR_WATCH_SUBSCRIPTION"
		value: "bot-ff-repeat-watch-sub"
	}, {
		name:  "GOOGLE_CALENDAR_WATCH_URL"
		value: "http://calendar-watch.private.svc.cluster.local:3000"
	}, {
		name:  "AWS_BUCKET"
		value: "rtmp-server-ff"
	}, {
		name:  "USER_RPC_CLIENT_SERVICE_NAME"
		value: "bot-ff"
	}, {
		name:  "USER_RPC_SERVER_ADDRESS"
		value: "user-service.private.svc.cluster.local:50051"
	}, {
		name:  "USER_RPC_ENABLE_INSECURE"
		value: "enabled"
	}, {
		name:  "REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name:  "PUPPET_REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name:  "USER_EVENT_QUEUE_BOT_FF_SUBSCRIPTION"
		value: "user-service-staging-bot-ff-sub"
	}, {
		name: "GMAIL_STMP_PASS"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GMAIL_STMP_PASS"
		}
	}, {
		name: "GMAIL_STMP_USER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GMAIL_STMP_USER"
		}
	}, {
		name: "ADMIN_MEETING_NOTE_EDIT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ADMIN_MEETING_NOTE_EDIT"
		}
	}, {
		name: "AIRTABLE_ACCESS_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AIRTABLE_ACCESS_KEY"
		}
	}, {
		name: "AIRTABLE_URL_CRYPT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AIRTABLE_URL_CRYPT"
		}
	}, {
		name: "API_AI_CLIENT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "API_AI_CLIENT"
		}
	}, {
		name: "API_AI_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "API_AI_SECRET"
		}
	}, {
		name: "APOLLO_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "APOLLO_API_KEY"
		}
	}, {
		name: "AUDIO_FF_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUDIO_FF_AUTH"
		}
	}, {
		name: "AUDIO_WORKER_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUDIO_WORKER_TOKEN"
		}
	}, {
		name: "AUTOPILOT_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUTOPILOT_KEY"
		}
	}, {
		name: "AWS_ACCESS_KEY_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AWS_ACCESS_KEY_ID"
		}
	}, {
		name: "AWS_SECRET_ACCESS_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AWS_SECRET_ACCESS_KEY"
		}
	}, {
		name: "CHROME_BASIC_FILTER_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "CHROME_BASIC_FILTER_TOKEN"
		}
	}, {
		name: "DELETE_ADMIN_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "DELETE_ADMIN_TOKEN"
		}
	}, {
		name: "DEV_SLACK_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "DEV_SLACK_CLIENT_SECRET"
		}
	}, {
		name: "ELASTIC_SEARCH_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ELASTIC_SEARCH_AUTH"
		}
	}, {
		name: "FF_SLACK_DEV_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "FF_SLACK_DEV_TOKEN"
		}
	}, {
		name: "FF_SLACK_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "FF_SLACK_TOKEN"
		}
	}, {
		name: "FF_VERIFY_SEND_EMAIL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "FF_VERIFY_SEND_EMAIL"
		}
	}, {
		name: "GQL_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_ACCESS_TOKEN"
		}
	}, {
		name: "GQL_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_AUTH"
		}
	}, {
		name: "HUBSPOT_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "HUBSPOT_API_KEY"
		}
	}, {
		name: "NIGHTMARE_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "NIGHTMARE_TOKEN"
		}
	}, {
		name: "NJWT_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "NJWT_ACCESS_TOKEN"
		}
	}, {
		name: "NJWT_REFRESH_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "NJWT_REFRESH_TOKEN"
		}
	}, {
		name: "NOW_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "NOW_TOKEN"
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
		name: "OFFICE_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_CLIENT_ID"
		}
	}, {
		name: "PAPERSPACE_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PAPERSPACE_API_KEY"
		}
	}, {
		name: "PARSE_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PARSE_PASSWORD"
		}
	}, {
		name: "PARTCIPANT_DISPATCH_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PARTCIPANT_DISPATCH_AUTH"
		}
	}, {
		name: "PAYMENTS_FF_AUTH_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PAYMENTS_FF_AUTH_USERNAME"
		}
	}, {
		name: "PAYMENTS_FF_AUTH_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PAYMENTS_FF_AUTH_PASSWORD"
		}
	}, {
		name: "PROD_SLACK_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PROD_SLACK_CLIENT_SECRET"
		}
	}, {
		name: "SEGMENT_WRITE_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SEGMENT_WRITE_KEY"
		}
	}, {
		name: "SENDGRID_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SENDGRID_API_KEY"
		}
	}, {
		name: "SLACK_BOT_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SLACK_BOT_TOKEN"
		}
	}, {
		name: "SLACK_SIGNING_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SLACK_SIGNING_SECRET"
		}
	}, {
		name: "SLACK_USER_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SLACK_USER_TOKEN"
		}
	}, {
		name: "SLACK_VERIFICATION_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SLACK_VERIFICATION_TOKEN"
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
		name: "WATSON_STT_PASS"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "WATSON_STT_PASS"
		}
	}, {
		name: "WATSON_STT_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "WATSON_STT_USERNAME"
		}
	}, {
		name: "WINSTON_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "WINSTON_TOKEN"
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
		name: "OFFICE_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_CLIENT_SECRET"
		}
	}]
	extraSecrets: []
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "bot.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     8001
			}]
		}]
		tls: [{
			hosts: [
				"bot.private.fireflies.dev",
			]
			secretName: "bot-private-fireflies-dev-tls"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    3
		maxReplicas:                    15
		targetCPUUtilizationPercentage: 70
	}
	labels: {
		app:        "bot-fireflies"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "bot-fireflies"
	}
}
