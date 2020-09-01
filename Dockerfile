FROM alpine:3

RUN apk update; \
        apk add --no-cache python3 py3-pip jq curl

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# install terraform
ENV TER_VER="0.12.28"
RUN wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip \
    && unzip terraform_${TER_VER}_linux_amd64.zip \
    && mv terraform /usr/local/bin/terraform \
    && rm terraform_${TER_VER}_linux_amd64.zip

# Install aws cli
RUN pip3 install awscli --upgrade

#install aws-iam-authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x ./aws-iam-authenticator \
    && mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

ENV AWS_ACCESS_KEY_ID=""
ENV AWS_SECRET_ACCESS_KEY="" 
ENV AWS_SESSION_TOKEN="" 
ENV AWS_SECURITY_TOKEN=""

ENV AWS_REGION="eu-central-1" 
ENV AWS_DEFAULT_REGION="eu-central-1"

