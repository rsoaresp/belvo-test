# Model registry

This is where we can define the model registry, responsible for storing all the experiments
performed and the corresponding metrics.

Since we decided to go with [MLFlow](https://mlflow.org/), we'll also use it to host
our models.

# What's happening

From a `ubuntu` docker image we install python,

```
RUN apt-get update && apt-get install -y build-essential wget python3 python3-pip
RUN pip3 install mlflow boto3
```

and conda,

```
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
```

and configure mlflow parameters,

```
ENV PATH=$CONDA_DIR/bin:$PATH

WORKDIR /opt/mlflow

EXPOSE 5000/tcp
```
