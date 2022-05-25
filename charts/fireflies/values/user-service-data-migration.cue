package fireflies

"user-service-data-migration": {
	fullnameOverride: "user-service-data-migration"
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/user-service-data-migration/user-service-data-migration"
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
	extraEnv: [{
		name:  "NODE_ENV"
		value: "production"
	}, {
		name: "MONGO_USERNAME"
		valueFrom: secretKeyRef: {
			name: "parse-admin-fireflies"
			key:  "username"
		}
	}, {
		name: "MONGO_PASSWORD"
		valueFrom: secretKeyRef: {
			name: "parse-admin-fireflies"
			key:  "password"
		}
	}, {
		name:  "PARSE_DB"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/parse-server?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "USE_NOTES_DB"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/use-notes-0?ssl=false&authSource=admin&tls=false&replicaSet=parse"
	}, {
		name:  "USER_SERVICE_DB"
		value: "mongodb+srv://$(MONGO_USERNAME):$(MONGO_PASSWORD)@parse-svc.private.svc.cluster.local/user-service-db?ssl=false&authSource=admin&tls=false&retryWrites=true&w=majority&readPreference=primaryPreferred&appname=user-service"
	}]
	probes: {
		// to revisit when we add grpc endpoints for readiness
		liveness: {
			enabled:             true
			mode:                "http"
			path:                "/health"
			port:                8080
			initialDelaySeconds: 30
			periodSeconds:       30
		}
		readiness: {
			enabled:             true
			mode:                "http"
			path:                "/health"
			port:                8080
			initialDelaySeconds: 30
			periodSeconds:       30
		}
	}
	labels: {
		app:        "user-service-data-migration"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "data-migration"
		component:  "user-service-data-migration"
	}
	linkerd: inject: "enabled"
}
