#!/bin/bash
# Mikey Garcia, @gikeymarcia
# select gcloud machines and do common actions with them
# dependencies: gcloud fzf get-clip.sh

# helper functions
get_actions () {
    for cmd in "${actions[@]}"; do echo "$cmd"; done
}
get_col () {
    printf "%s" "$2" | awk "{print \$$1}"
}
# get available machines
gcp_cache=/tmp/GCP-cache
cache_fresh="$(find $gcp_cache -mmin -10)"
if [ "$1" = "new" ] || [ ! -s $gcp_cache ] || [ ! "$cache_fresh" ] ; then
    rm -v $gcp_cache
    printf "%s\n%s\n\n" "Querying google for instances" \
                        "$ gcloud compute instances list"
    list=$(gcloud compute instances list)
    printf "using results from: %s\n" "$(date)"
    printf "%s" "$list" > $gcp_cache
elif [ "$cache_fresh" ] ; then
    list=$(cat $gcp_cache)
    printf "using cached results from:\n%s\n\n" "$(ls -l $gcp_cache)"
fi

# select machine
machine=$(printf "%s" "$list" | fzf --header-lines=1 \
    --height=30% --prompt="Choose which machine to act upon: ")
[ -z "$machine" ] && printf "%s\n" "$list" && exit
name=$(get_col 1 "$machine")
zone=$(get_col 2 "$machine")
printf "selected virtual machine:\n%s\n\n" "$machine"

# potential GCP commands
actions+=("gcloud compute instances start --zone=$zone $name")
actions+=("gcloud compute instances stop --zone=$zone $name")
actions+=("gcloud compute ssh --zone=$zone jupyter@$name -- -L 8080:localhost:8080")
actions+=("gcloud compute scp --zone=$zone filename jupyter@$name:~/")

# select command for machine
cmd=$(get_actions | fzf +m --prompt="What are you doing with '$name': ")

if [ -n "$cmd" ]; then
    ~/.scripts/commands/get-clip.sh "$cmd"
    # don't execute scp commands
    if [ "$(get_col 3 "$cmd")" = "scp" ]; then
        echo "$cmd"
    else
        $cmd
    fi
fi

# update cache and display all actions
gcloud compute instances list > $gcp_cache &
printf "\n%s\n%s\n" "--Possible actions" "$(get_actions)"
