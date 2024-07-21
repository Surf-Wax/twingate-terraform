# terraform.tfvars
# This is where you define your variables
# NOTE: if this file is not encrypted or otherwise protected,
#  theese variables are plaintext and need to be handled carefully

twingate_resource_address  = "192.168.1.3"  # Example IP, change to your resource's address
twingate_connector_name    = "home-computer-connector"  # Default value, change if needed
twingate_label_hostname   = "`hostname`"
twingate_label_deployed_by = "docker"       # Leave this default 
