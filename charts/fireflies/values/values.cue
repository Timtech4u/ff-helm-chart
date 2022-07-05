package fireflies

import app "fireflies.ai/helm-charts/charts/app"

[Service=_]: app.#App & {
	fullnameOverride: Service
}

_#config: {
	googleProjectId: string                @tag(googleProjectId)
	secretName:      *"ff-config" | string @tag(secretName)
}
