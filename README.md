#Belvo test

This repo contains material for Belvo's machine learning test.


#Creating an environment to explore and develop

The first thing we have to do is to create an exploratory environment to play with
the available data and start modeling. Furthermore, we want that our experiments be
reproducible and trackable, to truly deserve the _data science_ name.


##Configuring the environment

To mimic a production ready answer to the stated problem, we have packed two Docker images,
one with a Jupyter lab, with the most common scientific libraries, and another one with
[mlflow](https://mlflow.org/), that will help us track experiments (and also put them in production, later).

In order to build the images, run the following [docker-compose](https://docs.docker.com/compose/)

```bash
docker-compose build
```

and run it with

```bash
docker-compose up
```

During the loading of the containers, you will see the corresponding links to start the
services in your browser. They typically looks like `http://127.0.0.1:10000/lab?token=<token>`
for the Jupyter lab and `http://0.0.0.0:5000` for MLFlow.

##Adding library dependencies

You can add dependencies required by the exploratory environment by passing them on the
`dev-requirements.txt` file, located on the root folder. Remember that in order to apply
any changes you have to rebuild the container.


#Serving the models

After playing with the notebooks, we have a list of models stored that we can test locally
its behavior when encountering new data. We can look at the mlflow user interface to select
models that we want to test and serve them locally. Once you have the
corresponding id, from the list of tracked models, create its api with the command,

```bash
./local-serve.sh <model-id>
```

###Sending requests

In order to test locally if the model is working as expected and if they behave correctly
for each kind of payload, we can test it using Python's request library.

```python
# Create random data just to see that the endpoint is working.
columns=[f'var_{i}' for i in range(0, 200)]
random_data = pd.DataFrame(np.random.random((1, 200)), columns=columns)

# Make the request. We use to_json in order to convert the dataframe into the expected data format.
r = requests.post("http://0.0.0.0:8000/invocations", headers={"Content-Type": "application/json"}, data=random_data.to_json(orient='split'))
```
