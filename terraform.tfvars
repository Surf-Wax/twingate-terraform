# terraform.tfvars
# This is where you define your variables
# NOTE: if this file is not encrypted or otherwise protected,
#  theese variables are plaintext and need to be handled carefully

twingate_api_key           = "your_api_key_here"
twingate_network           = "your_network_id_here"
twingate_remote_network_name = "local_network"  # Default value, change if needed
twingate_user_email        = "user@example.com"
twingate_resource_address  = "192.168.1.1"  # Example IP, change to your resource's address
twingate_connector_name    = "home-computer-connector"  # Default value, change if needed
terraform_organization_name = "value"
terraform_workspace_name = "value"