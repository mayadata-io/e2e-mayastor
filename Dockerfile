# Docker file for packet pipelines
FROM ubuntu:16.04
# setup environment
RUN apt-get update -y && apt-get install -y \
    wget \
    software-properties-common \
    lsb-core \
    jq \
    python2.7 \
    git \ 
    curl \
    sudo
RUN apt-get install dialog apt-utils -y
# installing kubectl 
RUN sudo apt-get update && sudo apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN sudo touch /etc/apt/sources.list.d/kubernetes.list
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update
RUN sudo apt-get upgrade -y
RUN sudo apt-get install -y kubectl
# Installing ansible 
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN sudo python2.7 get-pip.py
RUN pip install ansible==2.6.1
#Installing gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN sudo apt-get update && sudo apt-get install google-cloud-sdk -y
RUN sudo python2.7 get-pip.py
#Insatalling kops V-1.14
RUN wget https://github.com/kubernetes/kops/releases/download/1.14.0/kops-linux-amd64
RUN chmod +x kops-linux-amd64
RUN mv kops-linux-amd64 /usr/local/bin/kops
# Installing ansible dependencies
RUN pip install google-auth
RUN pip install requests
RUN pip install apache-libcloud
RUN pip install --upgrade pip