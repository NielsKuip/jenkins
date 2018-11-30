FROM jenkins/jenkins:2.138.3



USER root
RUN apt-get update
RUN apt-get install -y apt-transport-https 
RUN apt-get install -y make 
RUN apt-get install -y apt-utils
RUN apt-get install -y golang


RUN rm -rf /var/lib/apt/lists/*
# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh \
  && rm -f /tmp/google-cloud-sdk.tar.gz

# Adding the package path to local
RUN curl -L https://dl.k8s.io/v1.10.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod 755 /usr/local/bin/kubectl


ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
ENV GOPATH=$HOME/go
