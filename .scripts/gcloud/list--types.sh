#!/bin/bash
# Mikey Garcia, @gikeymarcia
# checking google cloud for available machine types

machines=/tmp/gcloud-list-machines
accels=/tmp/gcloud-list-accels
export machines

## ACT ON GCLOUD FUNCTIONS
get_compute_types () {
    printf "%s\n\n\n" "Querying google compute engine for machine types..."
    gcloud compute machine-types     list > "$machines"
    gcloud compute accelerator-types list > "$accels"
}
show_accel () {
    printf "gpu: %s\n" "$accels"
    a_types=$(
        tail -n +2 $accels | awk '{print $1}' |
        grep -E -v "vws$" | sort | uniq
    )
    printf "%s\n" "$a_types" | column | sed "s/^/    /"
}
show_machine () {
    printf "\n\ncpu: %s\n" "$machines"
    m_types=$(
        tail -n +2 "$machines" | awk '{print $1}' |
        sort | sed -E 's -[0-9]+$  ' | uniq
    )
    printf "%s\n" "$m_types" | column | sed "s/^/    /"
}

# PULL ON FIRST RUN
if [ ! -r "$machines" ] || [ ! -r "$accels" ]; then get_compute_types; fi

case "$1" in
    new )
        get_compute_types
    ;;
    * )
        printf "Using cached results:\n%s\n\npass paramter 'new' to get new results.\n\n" \
            "$(ls -lh /tmp/gcloud-list-*)"
        show_machine
        show_accel
    ;;
esac


gpu=$(grep -v vws "$accels" | grep -v DEPRECATED |
        grep -v europe | grep -v asia | grep -v australia |
        fzf --header-lines=1 --prompt="Choose your gpu type: ")
printf "\n%s\n" "$gpu"


cpu=$(cat <(head -n 1 "$machines") \
          <(grep -v DEPRECATED "$machines" |
            grep -v asia- | grep -v europe | grep -v australia ) \
      | fzf --header-lines=1 --prompt="Choose your machine type: ")

# DISPLAY
figlet "choices"
printf "%s\n\n" "$cpu"
printf "%s\n\n" "$gpu"
