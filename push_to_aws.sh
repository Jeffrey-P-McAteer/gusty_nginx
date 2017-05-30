#!/bin/bash

# A bash script to push a django install to an AWS box running Amazon Linux.
# Will check for and manipulate nginx config appropriately.

print_help() {
	cat <<EOF
Usage:
    push_to_aws.sh -k ./path/to/id_rsa -H vm.fqdn.or.ip [-u username]

-k 	 path to SSH key for the aws box.
-H   hostname or IP of the aws box.
[-u] Optional, specifies the username for the box (defaults to ec2-user)

EOF
	exit 0
}

# Parse arguments
while getopts ":k:hH:u:" opt; do
	case $opt in
		k)
			AWS_KEY="$OPTARG"
		;;
		h)
			print_help
		;;
		H)
			AWS_HOST="$OPTARG"
		;;
		u)
			REMOTE_USER="$OPTARG"
		;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
		;;
	esac
done

if [[ -z "$AWS_KEY" ]]; then
	printf 'Where is the AWS key for use with SSH located? '
	read AWS_KEY
fi

if [[ -z "$AWS_HOST" ]]; then
	printf 'Enter the IP or FQDN of the target AWS box: '
	read AWS_HOST
fi

if [[ -z "$REMOTE_USER" ]]; then
	# Default for Amazon Linux?
	REMOTE_USER=ec2-user
fi

# Test connection
ssh -i "$AWS_KEY" $REMOTE_USER@$AWS_HOST 'echo this is printing from the AWS machine, $(hostname) at $(date)'

