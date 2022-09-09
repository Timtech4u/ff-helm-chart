package fireflies

"user-service": {
	fullnameOverride: "user-service"
	secretProject:    _#config.googleProjectId
	service: {
		exported: true
		type:     "ClusterIP"
	}
	replicaCount: 1
	image: url: "ghcr.io/firefliesai/user-service/user-service"
	ports: [{
		name:   "http"
		number: 4000
	}, {
		name:   "grpc"
		number: 50051
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
		name:  "MONGO_URI"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/user-service-db?ssl=false&authSource=admin&tls=false&retryWrites=true&w=majority&readPreference=primaryPreferred&appname=user-service"
	}, {
		name:  "USE_NOTES_MONGO_URL"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "GRPC_URL"
		value: "0.0.0.0:50051"
	}, {
		name:  "PUBSUB_TOPIC_NAME"
		value: _#config.prefix+"user-service-stream"
	}, {
		name:  "USE_NOTES_REGISTER_SUCCESS_CALL_BACK_URL"
		value: "/auth/welcome/user"
	}, {
		name:  "GOOGLE_AUTH_CALLBACK"
		value: "auth/google"
	}, {
		name:  "GOOGLE_AUTH_ENDPOINT"
		value: "https://accounts.google.com/o/oauth2/v2/auth"
	}, {
		name:  "GOOGLE_TOKEN_ENDPOINT"
		value: "https://oauth2.googleapis.com/token"
	}, {
		name:  "GOOGLE_IDENTITY_ENDPOINT"
		value: "https://www.googleapis.com/oauth2/v1/userinfo"
	}, {
		name:  "OFFICE_AUTH_CALLBACK"
		value: "auth/outlook"
	}, {
		name:  "OFFICE_AUTH_ENDPOINT"
		value: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"
	}, {
		name:  "OFFICE_TOKEN_ENDPOINT"
		value: "https://login.microsoftonline.com/common/oauth2/v2.0/token"
	}, {
		name:  "OFFICE_IDENTITY_ENDPOINT"
		value: "https://graph.microsoft.com/v1.0/me"
	}, {
		name:  "REFRESH_TOKEN_HEADER"
		value: "fireflies-updated-tokens"
	}, {
		name:  "GOOGLE_PROJECT_ID"
		value: "_#config.googleProjectId"
	}, {
		name:  "ROOT_URL"
		value: "https://user-service.private.fireflies.dev/"
	}, {
		name:  "USE_NOTES_CALL_BACK_URL"
		value: "https://private.fireflies.dev/"
	}, {
		name:  "GOOGLE_SUCCESS_CALL_BACK_URL"
		value: "google-auth"
	}, {
		name:  "OUTLOOK_SUCCESS_CALL_BACK_URL"
		value: "office365-auth"
	}, {
		name:  "SIGN_UP_SEGMENT_EVENT"
		value: "Signed Up"
	}, {
		name:  "LOGIN_VIA_SOUNDBITE_PAGE_SEGMENT_EVENT"
		value: "a login via soundbite page"
	}, {
		name:  "GRPC_VERBOSITY"
		value: "DEBUG"
	}, {
		name:  "GRPC_TRACE"
		value: "all"
	}, {
		name:  "SEGMENT_SUBSCRIBER_THREAD"
		value: "CE2JBA1CK^@T04KDQAB7"
	}, {
		name: "NODE_ENV"
		valueFrom: fieldRef: fieldPath: "metadata.namespace"
	}, {
		name: "GOOGLE_CLIENT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GOOGLE_CLIENT"
		}
	}, {
		name: "GOOGLE_S"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "GOOGLE_S"
		}
	}, {
		name: "OFFICE_CLIENT"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_CLIENT"
		}
	}, {
		name: "OFFICE_S"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "OFFICE_S"
		}
	}, {
		name: "TOKEN_VERIFIER"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "TOKEN_VERIFIER"
		}
	}, {
		name: "SLACK_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "SLACK_ACCESS_TOKEN"
		}
	}, {
		name: "DSN_URL"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "DSN_URL"
		}
	}, {
		name: "USE_NOTES_MONGO_USERNAME"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "USE_NOTES_MONGO_USERNAME"
		}
	}, {
		name: "USE_NOTES_MONGO_PASSWORD"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "USE_NOTES_MONGO_PASSWORD"
		}
	}, {
		name: "USE_NOTES_MONGO_URI"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "USE_NOTES_MONGO_URI"
		}
	}, {
		name: "ANALYTICS_SEGMENT_WRITE_KEY"
		valueFrom: secretKeyRef: {
			name: _#config.secretName
			key:  "ANALYTICS_SEGMENT_WRITE_KEY"
		}
	}]
	extraSecrets: []
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "user-service.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     4000
			}]
		}]
		tls: [{
			hosts: [
				"user-service.private.fireflies.dev",
			]
			secretName: "user-service-tls-secret"
		}]
	}
	probes: {
		// to revisit when we add grpc endpoints for readiness
		liveness: {
			enabled:             true
			mode:                "http"
			path:                "/health"
			port:                4000
			initialDelaySeconds: 30
			periodSeconds:       30
		}
		readiness: {
			enabled:             true
			mode:                "http"
			path:                "/health"
			port:                4000
			initialDelaySeconds: 30
			periodSeconds:       30
		}
	}
	autoscaling: {
		enabled:                        false
		minReplicas:                    1
		maxReplicas:                    9
		targetCPUUtilizationPercentage: 50
	}
	labels: {
		app:        "user-service"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		component:  "user-service"
	}
	linkerd: inject: "enabled"
}
