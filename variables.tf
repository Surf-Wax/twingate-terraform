# variables.tf
# Define all the variables used in main.tf

variable "twingate_api_key" {
  description = "API key for Twingate"
  type        = string
  sensitive   = true
}

variable "twingate_network" {
  description = "Network ID for Twingate"
  type        = string
}

variable "twingate_remote_network_name" {
  description = "Name of the remote network"
  type        = string
  default     = "local_network"
}

variable "twingate_user_id" {
  description = "id of the user, obtained through the URL string in the Admin Console"
  type        = string
}

variable "twingate_resource_address" {
  description = "Address of the Twingate resource"
  type        = string
  default     = "192.168.1.3" # Example IP
}

variable "twingate_connector_name" {
  description = "Name for the Twingate Connector"
  type        = string
  default     = "home-computer-connector"
}

variable "twingate_label_hostname" {
  description = "Hostname for Twingate label"
  type        = string
}

variable "twingate_label_deployed_by" {
  description = "Label for who deployed the container"
  type        = string
}