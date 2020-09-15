#!/bin/sh
# Mikey Garcia, @gikeymarcia
# create instances in google cloud with varying settings

# choose your configuration
case "$1" in
    "respectable-rock" )
        export INSTANCE_NAME="respectable-rock"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-t4,count=1"
        export ZONE="us-west1-b"
        export PREEMPTIBLE="false"
    ;;
    "central-mirror" )
        export INSTANCE_NAME="central-mirror"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-t4,count=1"
        export ZONE="us-central1-a"
        export PREEMPTIBLE="false"
    ;;
    "SAM" )
        export INSTANCE_NAME="down-south"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-t4,count=1"
        export ZONE="southamerica-east1-c"
        export PREEMPTIBLE="false"
    ;;
# preemptible instance
    "high-end" )
        export INSTANCE_NAME="budget-solid-central1c"
        export INSTANCE_TYPE="n1-highmem-8"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-p100,count=1"
        export ZONE="us-west1-b"
        export PREEMPTIBLE="true"
    ;;
    "budget" )
        export INSTANCE_NAME="budget-no-disconnect"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-t4,count=1"
        export ZONE="us-west1-b"
        export PREEMPTIBLE="false"
    ;;
    "central" )
        export INSTANCE_NAME="budget-central"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-gpu"
        export ACCEL_TYPE="type=nvidia-tesla-t4,count=1"
        export ZONE="us-central1-c"
        export PREEMPTIBLE="false"
    ;;
# cpu-only instance
    "cpu-west-rock" )
        export INSTANCE_NAME="cpu-west-rock"
        export INSTANCE_TYPE="n1-highmem-4"
        export IMAGE_FAMILY="pytorch-latest-cpu"
        export ZONE="us-west1-b"
        export PREEMPTIBLE="false"
    ;;
    * )
        printf "%s\n%s\n\n" "'$1' is not a valid input" "choose 'budget' or 'high-end'"
        exit
esac

# create instance
if [ $PREEMPTIBLE = "true" ]; then
    gcloud compute instances create "$INSTANCE_NAME" \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator=$ACCEL_TYPE \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=200GB \
        --metadata="install-nvidia-driver=True" \
        --preemptible
else
    gcloud compute instances create "$INSTANCE_NAME" \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator=$ACCEL_TYPE \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=200GB \
        --metadata="install-nvidia-driver=True"
fi
# reconfigure ssh to allow login
gcloud compute config-ssh
