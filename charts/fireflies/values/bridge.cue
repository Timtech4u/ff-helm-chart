package fireflies

bridge: {
	fullnameOverride: "bridge"
	secretProject:    _#config.googleProjectId
	replicaCount:        1
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
	extraEnv: [{
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
		name: "K8S_PUPPET_DISPATCH_STRING"
		key:  "K8S_PUPPET_DISPATCH_STRING"
	}, {
		name: "NODE_ENV"
		valueFrom: fieldRef: fieldPath: "metadata.namespace"
	}]
	ingress: {
		enabled:   true
		className: "nginx"
		hosts: [{
			host: "bridge-ff.fireflies.dev"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     8090
			}]
		}]
		tls: [{
			hosts: [
				"bridge-ff.fireflies.dev",
			]
			secretName: "bridge-tls-secret"
		}]
	}
	terminationGracePeriodSeconds: 80
	backendConfig: enabled: true
	linkerd: inject: "enabled"
	nodeSelector: "fireflies.ai/app": "fireflies"
}
