# CC-Project5
## Team Members : 

- NUNEPALLI JAYADEEP REDDY : PES2UG20CS235
- P DINESH KUMAR : PES2UG20CS236
- PATEL SAI KRISHNA REDDY : PES2UG20CS241
- PATHAN MOHAMMAD ARSHAD : PES2UG20CS242
## Problem Statement
Microservices are an architectural and organizational approach to software development where software is composed of small independent services that communicate over well-defined APIs. Microservices architectures make applications easier to scale and faster to develop, enabling innovation and accelerating time-to-market for new features.
Docker and Kubernetes are almost synonymous to 'microservices' as they help package and manage the different components of a project/ application, thereby easing up the implementation of a microservices architecture.

**In this project, you will work with Docker and Kubernetes to make an easily deployable and portable blogging web-app using Flask and MongoDB.**  

The microservices architecture will deploy a Kubernetes cluster with a mongodb server pod fronted with a web admin interface and a pod to run the flask app.

## Pre-Requisites/ Pre-Installation:
1. Docker ([Windows](https://docs.docker.com/desktop/windows/install/) | [Ubuntu](https://docs.docker.com/engine/install/ubuntu/#:~:text=Install%20from%20a%20package&text=Go%20to%20https%3A%2F%2Fdownload,version%20you%20want%20to%20install) | [MacOS](https://docs.docker.com/desktop/mac/install/))
2. Kubernetes ([Windows](https://birthday.play-with-docker.com/kubernetes-docker-desktop/) | [Ubuntu](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) | [MacOS](https://birthday.play-with-docker.com/kubernetes-docker-desktop/))

## File Structure
```
.
|-- README.md
|-- app
|   |-- app.py
|   |-- requirements.txt
|   `-- templates
|       |-- base.html
|       |-- create-post.html
|       |-- edit-post.html
|       `-- home.html
|-- configmap.yaml
|-- deployments.yaml
|-- flask-app-image.dockerfile
|-- secret.yaml
`-- services.yaml
```
The `app` directory contains all the code pertaining to the flask app. You are only required to configure the mongo connection string variables as specified in `app.py`.  
The `flask-app-image.dockerfile` should specify the insructions to assemble the docker image for the flask app.  
The `.yaml` files in the root directory are to specify the kubernetes manifests that will bring up your microservices deployment of the problem statement.

## Task Breakdown/ Deliverables:
1. MongoDB Server
    1. Use the `mongo` image publicly available on DockerHub. Read through the configuration and other details of the image [here](https://hub.docker.com/_/mongo). Note down the necessary environment variables to be configured.
    2. Create the `Deployment` for the mongodb server under `deployments.yaml`. Remember to configure the ports and setup the environment variables correctly.
    3. Environment variables such as username, password, etc. are sensitive information and are defined as a `Secret`. Define a `secret.yaml` file to hold the sensitive information required by the mongodb server. You may create a secret _using a configuration file_ and use the secret in your deployment as _an environment variable_.  [Read more](https://newrelic.com/blog/how-to-relic/how-to-use-kubernetes-secrets).
    4. Create a `Service` for the mongodb server under `services.yaml`.

2. Mongo-Express Web Service
    1. Use the `mongo-express` image. Note down the necessary environment variables like before from [here](https://hub.docker.com/_/mongo-express).
    2. Define a `configMap` to store the mongodb server url. As above, use the configmap to configure the container with environment variables. [Read more](https://kubernetes.io/docs/concepts/configuration/configmap/).
    3. Create a `Deployment` for the mongo-express service under `deployments.yaml` and configure the necessary ports and environment variables (drawn from the secret and configmap).
    4. Also define a `service` for the pod under `services.yaml`.

3.  Flask WebApp
    1. Use the image created from the `flask-app-image.dockerfile`.
    2. Create a `Deployment` for the flask app under `deployments.yaml`.
    3. Also define a `Service` for the pod in `services.yaml`.  

## Bringing it all together
Bring up all the microservices.
Once all the microservices are up and running,
1. Inside the flask-app pod, write and run a python script to insert records into the mongodb database. Insert into: database = 'blog' and collection = 'posts'.
2. Run `app.py` inside the pod. Visit `http://localhost:<port>/` to view the Blog App. The Home Page should display the records inserted into the database in the previous step.
<p align = "center">
    <img src = "https://user-images.githubusercontent.com/56164920/158070358-d37498a4-1712-4048-bf19-3dfc86a214ef.png"/>
</p>

3. You can view the database frontend exposed by mongo-express. To do so, on your browser, navigate to`EXTERNAL_IP:port` exposed by the mongo-express service. Here is the sample output:  

<p align = "center">
    <img src = "https://user-images.githubusercontent.com/56164920/158070411-3dff479d-ee7f-4eeb-b38f-92ccc221c6aa.png"/>
</p>

# Execution Steps

## Install dependencies
Install minikube, docker and kubernetes

## Start minikube

```script
minikube start
```

## Update envs

```script
eval $(minikube docker-env)
```
The above command works only in linux OSs. In case of windows, import flask-app image after building

## Build the flask-app image

Change to the directory containing these files

```script
docker-compose build --no-cache
```

If you are running minikube on windows, import the image

```script
minikube image load flask-app
```

## Apply all the files

```script
kubectl apply -f secrets.yaml
kubectl apply -f configmap.yaml
kubectl apply -f services.yaml
kubectl apply -f deployment.yaml
```
Do it one by one

## Make sure that all pods, services and deployments are running properly

```script
kubectl get pods
kubectl get svc
kubectl get deployments
```

Make sure that all of them are complete i.e. progress should be 1/1 or 2/2 or etc. Basically progress should be full

## View logs
In case of any errors, view the log of the pod

```script
kubectl logs <pod_name>
```

## Get minikube IP

```script
minikube ip
```

## Open Application

The services have exposed nodeports.

To view the nodeport:

```script
kubectl get svc
```
Open the application on firefox.
URL: http://<minikube_ip>:<nodeport>/
