package fireflies

queue: {
	fullnameOverride: "queue"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/queue-ff/queue-ff"
	ports: [{
		name:   "http"
		number: 8080
	}]
	resources: {
		limits: {
			cpu:    "500m"
			memory: "800Mi"
		}
		requests: {
			cpu:    "450m"
			memory: "700Mi"
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
		name:  "callJoinQueueTopic"
		value: "call-join-queue"
	}, {
		name:  "AUTOJOIN_PUBLISHER"
		value: "autojoin-queue"
	}, {
		name:  "AUTOJOIN_DELAYED_SUBSCRIPTION"
		value: "autojoin-delayed-queue-sub"
	}, {
		name:  "SCHEDULER_MESSAGE_QUEUE_TOPIC"
		value: "message-queue"
	}, {
		name:  "SCHEDULER_MESSAGE_QUEUE_SUBSCRIPTION"
		value: "message-queue-sub"
	}, {
		// - name: SCHEDULER_JOB_QUEUE
		//   value: STAGING_SCHEDULER_JOB_QUEUE
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
		name: "PUPPET_REDIS_URL"
		key:  "PUPPET_REDIS_URL"
	}, {
		name: "REDIS_URL"
		key:  "REDIS_URL"
	}, {
		name: "K8S_PUPPET_DISPATCH_STRING"
		key:  "K8S_PUPPET_DISPATCH_STRING"
	}]
	autoscaling: {
		enabled:                        false
		minReplicas:                    3
		maxReplicas:                    9
		targetCPUUtilizationPercentage: 50
	}
	labels: {
		app:        "queue-ff"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "queue-ff"
	}
}
