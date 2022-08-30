# Fireflies Required Secret

Fireflies by nature require many stuff to be set up like Google Project, OAUTH creds etc. The following are the list of keys to be present before do Helm installation

| Key | Services | Remarks |
| --- | -------- | ------- |
| REV_TOKEN | audio | |
| SENDGRID_API_KEY | audio, bot-fireflies, dashboard, participant-dispatch | |
| GQL_AUTH | audio | Seems like we just need to automatically generate this? |
| CRON_SERVICE_TOKEN | audio | Seems like we just need to automatically generate this? |
| AWS_ACCESS_KEY_ID | audio, participant-dispatch | |
| AWS_SECRET_ACCESS_KEY | audio, participant-dispatch | |
| ELASTIC_SEARCH_AUTH | audio, bot-fireflies, call-join, dashboard | Could be optional if the user asks to automatically deploy it alongside with the Fireflies helm chart |
| WORKFLOW_SERVICE_AUTH | audio | Seems like we just need to automatically generate this? |
| ASSEMBLY_TOKEN | audio | |
| API_KEY | audio | Seems like we just need to automatically generate this? |
| OPEN_AI_API_KEY | audio | |
| SLACK_ACCESS_TOKEN | audio, user-service | |
| SLACK_BOT_IMAGE | audio | |
| API_FF_TOKEN | audio | Seems like we just need to automatically generate this? |
| WORD_CAB_API_KEY | audio | |
| K8S_PUPPET_DISPATCH_STRING | audio, bridge, call-join, queue | Seems like we just need to automatically generate this? |
| SEGMENT_WRITE_KEY | audio, apollo, autojoin-worker, bot-fireflies, calendar, call-join, dashboard | |
| GROWTHBOOK_API_KEY | audio, call-join | |
| GQL_ACCESS_TOKEN | apollo, autojoin-worker, calendar, bot-fireflies, calendar-watch, call-join, dashboard, participant-dispatch | |
| SERVER_IP | apollo, call-join, participant-dispatch | |
| SERVER_PORT | apollo, call-join | |
| WINSTON_TOKEN | apollo | |
| WINSTON_SUBDOMAIN | apollo | |
| OAUTH_CLIENT_ID | apollo, autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join | |
| OAUTH_CLIENT_SECRET | apollo, autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join | |
| RABBIT_MQ_URL | apollo | |
| AUTO_JOIN_WORKER_QUEUE | apollo | |
| GCLOUD_PROJECT | apollo | |
| TWILIO_ACCOUNT_SID | apollo, autojoin-worker  | |
| TWILIO_AUTH_TOKEN | apollo, autojoin-worker, bot-fireflies, call-join | |
| TZ | apollo | |
| CALL_JOIN_URL | apollo | |
| CJ_URL | apollo | |
| CAPTCHA_API_KEY | apollo | |
| TRANSCODER_FF_URL | apollo | |
| DEEPGRAM_USERNAME | apollo | |
| DEEPGRAM_PASSWORD | apollo | |
| OVERWRITE_CHANNEL_ID | autojoin-worker | |
| REPORT_CHANNEL_ID | autojoin-worker | |
| SLACK_CHANNEL_ID | autojoin-worker | |
| OFFICE_CLIENT_ID | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join, dashboard | |
| OFFICE_CLIENT_SECRET | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join, dashboard | |
| QUEUE_PREFIX | autojoin-worker | |
| GOOGLE_CLIENT_ID | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join, dashboard | |
| GOOGLE_SECRET | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join, dashboard | |
| OUTLOOK_CLIENT_ID | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join | |
| OUTLOOK_SECRET | autojoin-worker, bot-fireflies, calendar, calendar-watch, call-join | |
| GMAIL_STMP_PASS | bot-fireflies | |
| GMAIL_STMP_USER | bot-fireflies | |
| ADMIN_MEETING_NOTE_EDIT | bot-fireflies, dashboard | |
| AIRTABLE_ACCESS_KEY | bot-fireflies | |
| AIRTABLE_URL_CRYPT| bot-fireflies | |
| API_AI_CLIENT | bot-fireflies | |
| API_AI_SECRET | bot-fireflies | |
| APOLLO_API_KEY | bot-fireflies | |
| AUDIO_FF_AUTH | bot-fireflies | |
| AUDIO_WORKER_TOKEN | bot-fireflies | |
| AUTOPILOT_KEY| bot-fireflies | |
| AWS_ACCESS_KEY_ID | bot-fireflies | |
| AWS_SECRET_ACCESS_KEY | bot-fireflies | |
| CHROME_BASIC_FILTER_TOKEN| bot-fireflies | |
| DELETE_ADMIN_TOKEN | bot-fireflies | |
| DEV_SLACK_CLIENT_SECRET | bot-fireflies | |
| FF_SLACK_DEV_TOKEN | bot-fireflies | |
| FF_SLACK_TOKEN | bot-fireflies | |
| FF_VERIFY_SEND_EMAIL | bot-fireflies | |
| GQL_AUTH | bot-fireflies | |
| HUBSPOT_API_KEY| bot-fireflies | |
| NIGHTMARE_TOKEN | bot-fireflies | |
| NJWT_ACCESS_TOKEN | bot-fireflies | |
| NJWT_REFRESH_TOKEN | bot-fireflies | |
| NOW_TOKEN | bot-fireflies, participant-dispatch | |
| PAPERSPACE_API_KEY | bot-fireflies | |
| PARSE_PASSWORD | bot-fireflies | |
| PARTCIPANT_DISPATCH_AUTH | bot-fireflies | |
| PAYMENTS_FF_AUTH_USERNAME | bot-fireflies | |
| PAYMENTS_FF_AUTH_PASSWORD | bot-fireflies | |
| PROD_SLACK_CLIENT_SECRET | bot-fireflies | |
| SLACK_BOT_TOKEN | bot-fireflies | |
| SLACK_SIGNING_SECRET | bot-fireflies | |
| SLACK_USER_TOKEN | bot-fireflies | |
| SLACK_VERIFICATION_TOKEN | bot-fireflies | |
| TWILIO_ACCOUNT_SID | bot-fireflies, call-join | |
| WATSON_STT_PASS | bot-fireflies | |
| WATSON_STT_USERNAME | bot-fireflies | |
| WINSTON_TOKEN | bot-fireflies | |
| SENTRY_DSN_URL | bridge, calendar, calendar-watch, download, user-service | |
| AUDIO_SERVICE_TOKEN | bridge, call-join | |
| BUCKET | bridge | |
| BASIC_AUTH_USERNAME | calendar, calendar-watch, call-join | |
| BASIC_AUTH_PASSWORD | calendar, calendar-watch, call-join | |
| OUTLOOK_TENANT | calendar, calendar-watch | |
| USE_NOTES_MONGO_DB_NAME | calendar-watch, call-join | |
| PUPPET_PROXY_USERNAME | call-join | |
| PUPPET_PROXY_PASSWORD | call-join | |
| PUPPET_PROXY_SERVER | call-join | |
| PUPPET_V2_AWS_SECRET_ACCESS_KEY | call-join | |
| PUPPET_V2_AWS_ACCESS_KEY_ID | call-join | |
| PUPPET_V2_ANTICAPTCHA_API_KEY | call-join | |
| PUPPET_V2_CAPTCHA_API_KEY | call-join | |
| PUPPET_MEETING_QUEUE | call-join | |
| OAUTH_SECRET | call-join | |
| PUBLIC_KEY_STRING | dashboard | |
| PRIVATE_KEY_STRING | dashboard | |
| KEY_PAIR_ID | dashboard | |
| ANALYTICS_PASSWORD | dashboard | |
| AZURE_CLIENT_ID | dashboard | |
| JWT_SECRET_KEY | dashboard | |
| ZENDESK_VISITOR_AUTH | dashboard | |
| ZAPIER_INVITE | dashboard | |
| STRIPE_SECRET_KEY | dashboard | |
| SENTRY_DSN_SERVER | dashboard | |
| S3_USE_NOTES_ACCESS | dashboard | |
| REACT_APP_STRIPE_PUBLIC_KEY | dashboard | |
| REACT_APP_SENTRY_DNS_SERVER | dashboard | |
| PAYMENTS_FF_PASSWORD | dashboard | |
| IMPERSONATE_ADMIN_KEY | dashboard | |
| CDN_URL | dashboard | |
| AUDIO_WORKER_AUTH | dashboard | |
| APOLLO_KEY | dashboard | |
| AWS_SECRET | download | |
| AWS_KEY | download | |
| PARTICIPANT_DISPATCH_AUTH | participant-dispatch | |
| ANALYTICS_SEGMENT_WRITE_KEY | user-service | |
| USE_NOTES_MONGO_URI | user-service | |
| USE_NOTES_MONGO_PASSWORD | user-service | |
| USE_NOTES_MONGO_USERNAME | user-service | |
| TOKEN_VERIFIER | user-service | |
| OFFICE_S | user-service | |
| OFFICE_CLIENT | user-service | |
| GOOGLE_S | user-service | |
| GOOGLE_CLIENT | user-service | |

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