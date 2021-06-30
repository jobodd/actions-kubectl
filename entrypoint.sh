#!/bin/sh

set -e

GCP_SERVICE_ACCOUNT="$1"
GCP_PROJECT="$2"
GCP_CLUSTER="$3"
GCP_ZONE="$4"
KUBECTL_COMMAND="$5"

# Decode base64 kubernetes config and pipe into config.json
echo "$GCP_SERVICE_ACCOUNT" | base64 -d > /tmp/config.json

# Authenticate gcloud as the account in config.json
gcloud auth activate-service-account --key-file /tmp/config.json

# Register the gcloud account against a GCP kubernetes cluster
gcloud container clusters get-credentials $GCP_CLUSTER --project $GCP_PROJECT --zone $GCP_ZONE

# Run kubectl command
kubectl $KUBECTL_COMMAND