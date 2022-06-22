# Fireflies Helm Charts

This helm charts is the Fireflies Helm Chart to deploy your own Fireflies deployment into a Kubernetes Cluster.

# Prerequisite

- A running Kubernetes Engine
- Google Service Account for accessing
    - PubSub
- MongoDB
- Redis
- ElasticSearch
- S3 Bucket

# List of Services

- [ ] analytics-ff
- [x] audio
- [x] apollo
- [x] autojoin-worker
- [x] bot-fireflies
- [x] bridge-ff
- [ ] bull-monitor-ff
- [x] calendar-ff
- [x] calendar-watch
- [x] call-join-ff
- [ ] commands-ff
- [x] download-ff
- [ ] integration-ff
- [x] join-queue-ff
- [ ] landing-ff
- [x] mailin-server
- [ ] media-storage-ff
- [ ] mongo-oplog-ff
- [ ] notifications-ff
- [x] participant-dispatch-ff
- [ ] payments-ff
- [ ] public-api-ff
- [x] queue-ff
- [ ] segment-webhooks-ff
- [x] use-notes (under dashboard name)
- [x] user-service
- [x] user-service-data-migration