package fireflies

calendar: {
	fullnameOverride: "calendar"
	secretProject:    _#config.googleProjectId
	replicaCount:     1
	image: url: "ghcr.io/firefliesai/calendar-ff/calendar-ff"
	ports: [{
		name:   "http"
		number: 4010
	}]
	extraEnv: [{
		name:  "NODE_ENV"
		value: "staging"
	}, {
		name:  "TZ"
		value: "America/New_York"
	}, {
		name:  "NEW_RELIC_APP_NAME"
		value: "private-cloud-dashboard"
	}, {
		name:  "USE_NOTES_MONGO_DB_NAME"
		value: "use-notes-0"
	}, {
		name:  "GQL_URL"
		value: "http://dashboard.private.svc.cluster.local:3000"
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
		name: "GCLOUD_PROJECT"
		value: _#config.googleProjectId
	}, {
		name: "REDIS_URL"
		value: "redis://redis-master.private.svc.cluster.local:6379"
	}, {
		name: "GENERALSCHEDULER_TOPIC"
		value: "message-queue"
	}]
	extraSecrets: [{
		name: "GQL_ACCESS_TOKEN"
		key: "GQL_ACCESS_TOKEN"
	}, {
		name: "SEGMENT_WRITE_KEY"
		key:  "SEGMENT_WRITE_KEY"
	}, {
		name: "BASIC_AUTH_USERNAME"
		key:  "BASIC_AUTH_USERNAME"
	}, {
		name: "BASIC_AUTH_PASSWORD"
		key:  "BASIC_AUTH_PASSWORD"
	}, {
		name: "OUTLOOK_CLIENT_ID"
		key:  "OUTLOOK_CLIENT_ID"
	}, {
		name: "OUTLOOK_SECRED"
		key:  "OUTLOOK_SECRED"
	}, {
		name: "OUTLOOK_TENANT"
		key:  "OUTLOOK_TENANT"
	}, {
		name: "GOOGLE_CLIENT_ID"
		key:  "GOOGLE_CLIENT_ID"
	}, {
		name: "GOOGLE_SECRET"
		key:  "GOOGLE_SECRET"
	}, {
		name: "OAUTH_CLIENT_ID"
		key:  "OAUTH_CLIENT_ID"
	}, {
		name: "OAUTH_CLIENT_SECRET"
		key:  "OAUTH_CLIENT_SECRET"
	}, {
		name: "OFFICE_CLIENT_ID"
		key:  "OFFICE_CLIENT_ID"
	}, {
		name: "OFFICE_CLIENT_SECRET"
		key:  "OFFICE_CLIENT_SECRET"
	}, {
		name: "SENTRY_DSN_URL"
		key:  "SENTRY_DSN_URL"
	}]
	ingress: {
		enabled:   false
		className: "nginx"
		hosts: [{
			host: "calendar.firefliesapp.com"
			paths: [{
				path:     "/"
				pathType: "Prefix"
				port:     4010
			}]
		}]
		tls: [{
			hosts: [
				"calendar.firefliesapp.com",
			]
			secretName: "calendar-prod-tls-secret"
		}]
	}
	labels: {
		app:        "calendar-ff"
		owner:      "call-funnelers"
		costcenter: "call-funnelers"
		purpose:    "on-prem"
		component:  "calendar-ff"
	}
}
