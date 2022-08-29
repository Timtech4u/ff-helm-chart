# Fireflies Required Secret

Fireflies by nature require many stuff to be set up like Google Project, OAUTH creds etc. The following are the list of keys to be present before do Helm installation

| Key | Services | Remarks |
| --- | -------- | ------- |
| REV_TOKEN | audio | |
| SENDGRID_API_KEY | audio | |
| GQL_AUTH | audio | Seems like we just need to automatically generate this? |
| CRON_SERVICE_TOKEN | audio | Seems like we just need to automatically generate this? |
| AWS_ACCESS_KEY_ID | audio | |
| AWS_SECRET_ACCESS_KEY | audio | |
| ELASTIC_SEARCH_AUTH | audio | Could be optional if the user asks to automatically deploy it alongside with the Fireflies helm chart |
| WORKFLOW_SERVICE_AUTH | audio | Seems like we just need to automatically generate this? |
| ASSEMBLY_TOKEN | audio | |
| API_KEY | audio | Seems like we just need to automatically generate this? |
| OPEN_AI_API_KEY | audio | |
| SLACK_ACCESS_TOKEN | audio | |
| SLACK_BOT_IMAGE | audio | |
| API_FF_TOKEN | audio | Seems like we just need to automatically generate this? |
| WORD_CAB_API_KEY | audio | |
| K8S_PUPPET_DISPATCH_STRING | audio | Seems like we just need to automatically generate this? |
| SEGMENT_WRITE_KEY | audio | |
| GROWTHBOOK_API_KEY | audio | |
| GQL_ACCESS_TOKEN | apollo | |
| SERVER_IP | apollo | |
| SERVER_PORT | apollo | |
| WINSTON_TOKEN | apollo | |
| WINSTON_SUBDOMAIN | apollo | |
| OAUTH_CLIENT_ID | apollo | |
| OAUTH_CLIENT_SECRET | apollo | |
| AUTO_JOIN_WORKER_QUEUE | apollo | |
| GCLOUD_PROJECT | apollo | |
| TWILIO_ACCOUNT_SID | apollo | |
| TWILIO_AUTH_TOKEN | apollo | |
| SEGMENT_WRITE_KEY | apollo | |
| TZ | apollo | |
| CALL_JOIN_URL | apollo | |
| CJ_URL | apollo | |
| CAPTCHA_API_KEY | apollo | |
| TRANSCODER_FF_URL | apollo | |
| DEEPGRAM_USERNAME | apollo | |
| DEEPGRAM_PASSWORD | apollo | |

# Example

Before do `helm install` command, private cloud user required to create a Kubernetes secret with the following content

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-fireflies-config
type: Opaque
stringData:
  REV_TOKEN: asdfasdfasdfads
  SENDGRID_API_KEY: asdfasdfsadfasf
```