package fireflies

"join-queue": {
	fullnameOverride: "join-queue"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/join-queue-ff/join-queue-ff"
	ports: [{
		name:   "http"
		number: 8090
	}]
	resources: {
		limits: {
			cpu:    "300m"
			memory: "500Mi"
		}
		requests: {
			cpu:    "250m"
			memory: "450Mi"
		}
	}
	serviceAccount: {
		create: false
		name:   "fireflies"
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
		name:  "K8S_TARGET_NAMESPACE"
		value: "private"
	}, {
		name:  "K8S_USE_IN_CLUSTER_ACCESS"
		value: "true"
	}, {
		name:  "googleProjectId"
		value: _#config.googleProjectId
	}, {
		name:  "K8S_POD_SUB"
		value: "k8s-join-queue-sub"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		// This NODE_ENV used for namespace target :|
		name:  "NODE_ENV"
		value: "private"
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
		name:  "SCHEDULER_JOB_QUEUE"
		value: "STAGING_SCHEDULER_JOB_QUEUE"
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
		name: "K8S_USABLE_CLUSTERS"
		value: """
			[{
			  \"ip\": \"34.68.129.101\",
			  \"region\": \"us-central1-c\",
			  \"name\": \"main\"
			}]
			"""
	}, {
		name:  "PUPPET_REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name:  "REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}]

	extraSecrets: []
	labels: {
		app:        "join-queue-ff"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "integration-ff"
	}
}
