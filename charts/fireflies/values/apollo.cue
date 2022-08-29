package fireflies

apollo: {
	fullnameOverride: "apollo"
	secretProject:    _#config.googleProjectId
	image: url: "ghcr.io/firefliesai/apollo-ff/apollo-ff"
	ports: [{
		name:   "http"
		number: 3000
	}]
	resources: {
		limits: {
			cpu:    "400m"
			memory: "2Gi"
		}
		requests: {
			cpu:    "390m"
			memory: "1.9Gi"
		}
	}

	extraEnv: [{
		name:  "REDIS_URL"
		value: "redis://user:Na7_Bymivusyfedus0_Licacig8@redis-master.private.svc.cluster.local:6379"
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
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(PARSE_USERNAME):$(PARSE_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "USE_GOOGLE_SECRETS"
		value: "true"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		name: "GQL_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GQL_ACCESS_TOKEN"
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
		name: "WINSTON_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "WINSTON_TOKEN"
		}
	}, {
		name: "WINSTON_SUBDOMAIN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "WINSTON_SUBDOMAIN"
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
		name: "AUTO_JOIN_WORKER_QUEUE"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "AUTO_JOIN_WORKER_QUEUE"
		}
	}, {
		name: "GCLOUD_PROJECT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GCLOUD_PROJECT"
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
		name: "SEGMENT_WRITE_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SEGMENT_WRITE_KEY"
		}
	}, {
		name: "TZ"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "TZ"
		}
	}, {
		name: "CALL_JOIN_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "CALL_JOIN_URL"
		}
	}, {
		name: "CJ_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "CJ_URL"
		}
	}, {
		name: "CAPTCHA_API_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "CAPTCHA_API_KEY"
		}
	}, {
		name: "TRANSCODER_FF_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "TRANSCODER_FF_URL"
		}
	}, {
		name: "DEEPGRAM_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "DEEPGRAM_USERNAME"
		}
	}, {
		name: "DEEPGRAM_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "DEEPGRAM_PASSWORD"
		}
	}]
	extraSecrets: []

	ingress: {
		annotations: {
			"cert-manager.io/cluster-issuer":               "letsencrypt-prod"
			"nginx.ingress.kubernetes.io/service-upstream": "true"
		}
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "apollo.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     3000
			}]
		}]
		tls: [{
			hosts: [
				"apollo.private.fireflies.dev",
			]
			secretName: "apollo-private-fireflies-dev-tls"
		}]
	}
	probes: {
		liveness: {
			enabled:             false
			mode:                "http"
			path:                "/health"
			port:                3000
			initialDelaySeconds: 0
			periodSeconds:       10
		}
		readiness: {
			enabled:             false
			mode:                "http"
			path:                "/health"
			port:                3000
			initialDelaySeconds: 0
			periodSeconds:       10
		}
	}
}
