#!/bin/bash

model_id=$1

# Since we use mlflow with a local model store, find where the desired model is and pass
# the path to the contaner as a volume
path=$(find "$(pwd)" -name $model_id)
docker run --rm \
-p 8000:5000 \
-v "$path":/opt/mlflow/ \
--entrypoint="mlflow" \
mlflow_server models serve -m artifacts/model -h 0.0.0.0 -p 5000
