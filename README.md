# Okta Bootstrap

This terraform module act as a template for automating Okta using Terraform
and Jenkins. 

## Deployment

### State

The state is stored locally, but for running this in Jenkins, you probably 
want to use an enduring storage facility, like S3 or Azure Storage Account. 

### Running from MacOS, Linux or Windows 

Before running this on a local machine, you'll need an Okta account, and an
API token and have Terraform 1.0 or later installed. 

You'll need to set up some environment variables. 

```
export OKTA_ORG_NAME=dev-1234567
export OKTA_BASE_URL=okta.com
export OKTA_API_TOKEN=1234
```

You should run terraform init

```
terraform init
```

And to see what changes will be made

```
terraform plan
```

And then to apply the changes

```
terraform apply
```

## Testing

In order to test this terraform module, you can use docker. Within MacOS or
Linux you can use the following commands. It creates a jenkins directory in
your home directory. 

```
mkdir -p ~/jenkins
docker run \
  --name "Jenkins" \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v $HOME/jenkins:/var/cloudbees-jenkins-distribution \
  -v /var/run/docker.sock:/var/run/docker.sock \
  cloudbees/cloudbees-jenkins-distribution
```

You'll need to go through the setup steps by visiting http://localhost:8080. 
You'll also need to add the Git repository to Jenkins.

### Setting up Jenkins

In order for this to run in Jenkins, you'll need to create secrets that
match to the following environment variables.

Environment Variable | Secret Name | Example
---------|----------|---------
 OKTA_ORG_NAME | okta-org-name | dev-1234567
 OKTA_BASE_URL | okta-base-url | okta.com
 OKTA_API_TOKEN | okta-api-token | 1234

 As for managing state, you'll need to find a place for persistent storage.

### Running

The `Jenkinsfile` is configured to run `terraform plan` which allows you to
review the changes. You'll have 60 minutes to "approve" the change, which
will then run `terraform apply`. 



