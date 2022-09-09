package fireflies

"participant-dispatch": {
	fullnameOverride: "participant-dispatch"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/participant-dispatch-ff/participant-dispatch-ff"
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "500m"
			memory: "500Mi"
		}
		requests: {
			cpu:    "400m"
			memory: "350Mi"
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
		name:  "EMAIL_TOPIC"
		value: _#config.prefix+"EMAIL_TOPIC_STAGING"
	}, {
		name:  "TZ"
		value: "America/New_York"
	}, {
		name:  "FILE_START_DIR"
		value: "/tmp/"
	}, {
		// - name: PARTICPANT_DISPATCH_QUEUE_PREFIX
		//   value: PARTICIPANT_JOB_QUEUE_STAGING
		// - name: EMAIL_QUEUE_PREFIX
		//   value: EMAIL_QUEUE_PREFIX
		// - name: COMPLIANCE_TOPIC
		//   value: COMPLIANCE_TOPIC_STAGING
		name:  "AWS_BUCKET"
		value: "rtmp-server-ff"
	}, {
		name:  "AWS_REGION"
		value: "us-east-1"
	}, {
		name:  "PARTICPANT_DISPATCH_EMAIL_TOPIC"
		value: "participant-dispatch-ff-events"
	}, {
		name:  "PARTICPANT_DISPATCH_TOPIC"
		value: _#config.prefix+"participant-dispatch-queue"
	}, {
		name:  "PARTICPANT_DISPATCH_SUBSCRIPTION"
		value: "participant-dispatch-queue-sub"
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
		name:  "REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
	}, {
		name: "GQL_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_ACCESS_TOKEN"
		}
	}, {
		name: "PARTICIPANT_DISPATCH_AUTH"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "PARTICIPANT_DISPATCH_AUTHL"
		}
	}, {
		name: "SENDGRID_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SENDGRID_API_KEY"
		}
	}, {
		name: "NOW_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "NOW_TOKEN"
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
	}]
	extraSecrets: []
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "participant-dispatch.firefliesapp.com"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"participant-dispatch.firefliesapp.com",
			]
			secretName: "participant-dispatch-prod-tls-secret"
		}]
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    1
		maxReplicas:                    15
		targetCPUUtilizationPercentage: 80
	}
	labels: {
		app:        "participant-dispatch-ff"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "participant-dispatch-ff"
	}
}
