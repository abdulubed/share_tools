#!/bin/bash

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

roleSessionName=my-example-session
arnOfRoleToAssume=arn:aws:iam::$1:role/Jenkins-Role
assumeRoleEnv=$(aws sts assume-role \
            --role-session-name="$roleSessionName" \
            --role-arn="$arnOfRoleToAssume"\
            --output text \
            --query='Credentials.[
            join(`=`, [`AWS_ACCESS_KEY_ID`, AccessKeyId]),
            join(`=`, [`AWS_SECRET_ACCESS_KEY`, SecretAccessKey]),
            join(`=`, [`AWS_SESSION_TOKEN`, SessionToken])
          ]') && export $assumeRoleEnv
# python -c 'import socket;print socket.gethostbyname("fsadykov.com")'
# unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN



export AWS_DEFAULT_REGION="us-west-2"