terraform {
    required_providers {
        twingate = {
            source = "Twingate/twingate"
            version = ">=3.0.7"
        }
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

# Set up the twingate provider
provider "twingate" {
    api_token = var.twingate_api_key
    network = var.twingate_network
}

# Establish remote network
resource "twingate_remote_network" "local_network" {
    name = var.twingate_remote_network_name
    location = "ON_PREMISE"
}

# Establish connector
resource "twingate_connector" "local_connector" {
    remote_network_id = twingate_remote_network.local_network.id
}

# Generate tokens for connector
resource "twingate_connector_tokens" "local_connector_tokens" {
    connector_id = twingate_connector.local_connector.id
}

# Define user(s)
data "twingate_user" "local_user" {
    id = var.twingate_user_id
}

# Pull in the default twingate security policy(ies)
data "twingate_security_policy" "default_policy" {
    name = "Default Policy"
}

# Create twingate group(s) for accessing resource
resource "twingate_group" "local_group" {
    name = "local_group"
    security_policy_id = data.twingate_security_policy.default_policy.id
    user_ids = [data.twingate_user.local_user.id] # add more user IDs
}
# Create more groups here for additional access control


# Define twingate resource(s) (servers)
resource "twingate_resource" "resource" {
    name = "server"
    address = var.twingate_resource_address
    remote_network_id = twingate_remote_network.local_network.id

    protocols = {
        allow_icmp = false
        tcp = {
            policy = "RESTRICTED"
            ports = ["25565"] # Minecraft server, for example
        }
        udp = {
            policy = "DENY_ALL"
        }
    }

    # Adding a single group via `access_group`, use `dynamic "access_group"` for multiple 
    access_group {
        group_id = twingate_group.local_group.id
        security_policy_id = data.twingate_security_policy.default_policy.id
        usage_based_autolock_duration_days = 30
    }
}
