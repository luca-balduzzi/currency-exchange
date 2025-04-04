#!/bin/bash

# Exit on error
set -e

# Variables
PROJECT_ID="huware-currencyxe-dev"
WORKFLOW_NAME="wf-currency-exchange"
REGION="europe-west8"
WORKFLOW_FILE="./workflows/wf-currency-exchange.yaml"
SERVICE_ACCOUNT="sa-currencyxe@huware-currencyxe-dev.iam.gserviceaccount.com"
WORKFLOW_DESCRIPTION="The workflow automates the extraction and management of financial data using Google Sheets, BigQuery, Dataform, and Firestore. It handles the creation of the spreadsheet, the scheduling of Dataform flows, and the update of tables in BigQuery."

# Authenticate if not already authenticated
if ! gcloud auth list --format="value(account)" | grep -q "@"; then
    echo "No active authentication found. Running gcloud auth login..."
    gcloud auth login
fi

# Deploy the workflow
echo "Deploying workflow: $WORKFLOW_NAME..."
gcloud workflows deploy $WORKFLOW_NAME \
    --location=$REGION \
    --source=$WORKFLOW_FILE \
    --project=$PROJECT_ID \
    --service-account=$SERVICE_ACCOUNT \
    --description="$WORKFLOW_DESCRIPTION"

# Verify deployment
echo "Workflow deployment completed. Checking status..."
gcloud workflows describe $WORKFLOW_NAME --location=$REGION

echo "Deployment successful!"
