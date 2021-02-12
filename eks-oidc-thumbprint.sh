#!/usr/bin/env bash
EKS_URL="oidc.eks.${1}.amazonaws.com"
THUMBPRINT=$(openssl s_client -servername ${EKS_URL} -showcerts -connect ${EKS_URL}:443 </dev/null 2>&1 \
    | openssl x509 -fingerprint -noout | awk -F= '{print tolower($2)}' | sed 'ss:ssg')
echo -en "{\"value\": \"${THUMBPRINT}\"}"