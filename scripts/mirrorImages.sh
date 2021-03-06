#!/bin/bash

set -euo pipefail

declare -A imagearray=()
imagearray["gcr.io/kpt-functions/read-yaml"]="gcr.io/config-management-release/read-yaml"
imagearray["gcr.io/kpt-functions/write-yaml"]="gcr.io/config-management-release/write-yaml"
imagearray["gcr.io/kpt-functions/gatekeeper-validate"]="gcr.io/config-management-release/policy-controller-validate"
imagearray["gcr.io/kpt-dev/kpt"]="gcr.io/config-management-release/kpt"

for image in "${!imagearray[@]}"; do
  docker pull ${image}
  docker tag ${image} ${imagearray[$image]}:latest
  docker tag ${image} ${imagearray[$image]}:stable
  docker push ${imagearray[$image]}:latest
  docker push ${imagearray[$image]}:stable
done
