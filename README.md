# Twingate Network IaC with Terraform

### Disclaimer: 
This project was built using Nix Flakes. To enable the use of flakes on your system, ...

### Description:
Twingate is a remote access solution marketed as a VPN alternative that makes zero-trust architecture simple and intuitive to utilize. I use twingate to implement secure remote access to my personal resources. I started using it after I ran a Minecraft server in a docker container on my local machine, and made it (only the specific container and port) available to my brother (only his machine, and authenticated with his google account) via it's local IP address. You can read more about Twingate here.
I created this repository, both to demonstrate my proficiency with HashiCorp Terraform, and to try out using nix flakes for development. 

#### Dependencies:
- Nix (with flakes enabled)
- Docker
- Direnv
#### Layout: 
```
twingate-terraform
 |-->.envrc
 |-->backend.tf
 |-->flake.lock  
 |-->flake.nix  
 |-->main.tf  
 |-->README.md  
 |-->secrets.nix  
 |-->terraform.tfvars  
 |-->twingate-connector.tf  
 +-->variables.tf
 ```

`.envrc` By using direnv's .envrc file and including "use flake", we can build the nix flake automatically just by changing our working directory into the repository folder. 
`flake.nix` contains the instructions to build our development environment, which will fetch terraform and make it available to the user's shell along with environment variables. This file also imports `secrets.nix` to populate these environment variables with sensitive information to be used in terraform - such as the user's twingate API key and network names.
`flake.lock` pins packages built in the flake to specific versions, ensuring security and a reproducible environment.
`backend.tf` defines the desired terraform back-end to be used. For this example, I used Terraform Cloud.
`main.tf` defines our network resources and access policies. In this file you will find a user, security policy and an access group configured along with a remote network, a connector to deploy on said network, and our main resource making port 25565 available to said access group, which includes only our defined user.
`variables.tf` defines the variables to be used in `main.tf`.
`twingate.tfvars` populates the resource IP variable address along with some other twingate-related variables.
`twingate-connector.tf` (change this to deploy via docker)

### Instructions
1. Install dependencies & enable flakes
2. Clone this repository
3. Change directory into the repository (run `direnv allow` if necessary)
4. Enter your twingate network information into `secrets.nix` and your backend information into `backend.tf` (I used Terraform Cloud)
5. Log into terraform with `terraform login`
6. Terraform init, terraform plan, terraform apply
7. Deploy the twingate connector via docker via twingate admin console

### TODO:
- Automate twingate connector docker container deployment via the terraform code using user tokens stored in environment variables
