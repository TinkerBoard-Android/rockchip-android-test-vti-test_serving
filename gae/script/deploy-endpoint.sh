#!/bin/bash
#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ "$#" -ne 1 ]; then
  echo "usage: deploy-endpoint.sh prod|test|public"
  exit 1
fi

if [ $1 = "prod" ]; then
  SERVICE="vtslab-schedule-prod.appspot.com"
elif [ $1 = "public" ]; then
  SERVICE="vtslab-schedule.appspot.com"
else
  SERVICE="vtslab-schedule-test.appspot.com"
fi

echo "Depolying the endpoint API implementation to $SERVICE ..."

gcloud endpoints services deploy build_infov1openapi.json
gcloud endpoints services deploy host_infov1openapi.json
gcloud endpoints services deploy lab_infov1openapi.json
gcloud endpoints services deploy schedule_infov1openapi.json
gcloud endpoints configs list --service=$SERVICE

echo "Deployment done!"

vi app.yaml
