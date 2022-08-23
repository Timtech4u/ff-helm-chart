package fireflies

bridge: {
	fullnameOverride: "bridge"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/bridge-ff/bridge-ff"
	ports: [{
		name:   "http"
		number: 8090
	}]
	resources: {
		limits: {
			cpu:    "250m"
			memory: "480Mi"
		}
		requests: {
			cpu:    "200m"
			memory: "400Mi"
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
	extraSecrets: [{
		name: "K8S_PUPPET_DISPATCH_STRING"
		key:  "K8S_PUPPET_DISPATCH_STRING"
	}, {
		name: "SENTRY_DSN_URL"
		key:  "SENTRY_DSN_URL"
	}, {
		name: "AUDIO_SERVICE_TOKEN"
		key:  "AUDIO_SERVICE_TOKEN"
	}, {
		name: "BUCKET"
		key:  "BUCKET"
	}]
	extraEnv: [{
		name:  "GOOGLE_PROJECT_ID"
		value: _#config.googleProjectId
	}, {
		name:  "googleProjectId"
		value: _#config.googleProjectId
	}, {
		name:  "GOOGLE_APPLICATION_CREDENTIALS"
		value: "/var/secrets/google/key.json"
	}, {
		name:  "USER_SERVICE_GRPC_URL"
		value: "user-service.staging.svc.cluster.local:50051"
	}, {
		name:  "ENABLE_INSECURE"
		value: "enabled"
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
		name:  "DEFAULT_DATABASE_URI"
		value: "mongodb+srv://$(PARSE_USERNAME):$(PARSE_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name: "NODE_ENV"
		valueFrom: fieldRef: fieldPath: "metadata.namespace"
	}, {
		name:  "GQL_URL"
		value: "http://bot-fireflies.private.svc.cluster.local:8001/graphql"
	}, {
		name:  "PUB_SUB_SUBSCRIPTION"
		value: "puppet-queue-sub"
	}, {
		name:  "AUDIO_SERVICE"
		value: "http://audio.private.svc.cluster.local:3000"
	}, {
		name:  "USER_SERVICE_GRPC_ENDPOINT"
		value: "user-service.private.svc.cluster.local:50051"
	}]
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "bridge-ff.private.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     8090
			}]
		}]
		tls: [{
			hosts: [
				"bridge-ff.private.fireflies.dev",
			]
			secretName: "bridge-private-tls-secret"
		}]
	}
	terminationGracePeriodSeconds: 80
	backendConfig: enabled: true
	linkerd: inject:        "enabled"
}
