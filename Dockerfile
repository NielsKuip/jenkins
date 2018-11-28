FROM jenkins:2.60.3

FROM golang:latest 
RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 
RUN go build -o main . 
CMD ["/app/main"]

USER root
RUN apt-get update || apt-get update
RUN apt-get install -y apt-transport-https 
RUN apt-get install -y make 
RUN rm -rf /var/lib/apt/lists/*
# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh \
  && rm -f /tmp/google-cloud-sdk.tar.gz

RUN curl -L https://dl.k8s.io/v1.10.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
# Adding the package path to local

RUN add-apt-repository ppa:gophers/archive
RUN sudo apt-get update
RUN apt-get install golang-1.10-go

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
