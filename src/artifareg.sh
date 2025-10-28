#!/bin/bash

# Create the Docker repository
export PROJECT_ID=$(gcloud config get-value project)

gcloud artifacts repositories create example-docker-repo --repository-format=docker \
    --location=europe-west4 --description="Docker repository" \
    --project=$PROJECT_ID
	
gcloud artifacts repositories list \
    --project=$PROJECT_ID
	
# Configure authentication for Artifact Registry
gcloud auth configure-docker europe-west4-docker.pkg.dev

# Obtain sample image to push
docker pull us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0

# Tag the image with a registry name
docker tag us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0 \
europe-west4-docker.pkg.dev/$PROJECT_ID/example-docker-repo/sample-image:tag1

# Push the image to Artifact Registry
docker push europe-west4-docker.pkg.dev/$PROJECT_ID/example-docker-repo/sample-image:tag1

# Pull the image from Artifact Registry
docker pull europe-west4-docker.pkg.dev/$PROJECT_ID/example-docker-repo/sample-image:tag1
