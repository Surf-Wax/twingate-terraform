
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_image" "twingate_connector" {
  name         = "twingate/connector:1"
}

resource "docker_container" "twingate_connector" {
  image = docker_image.twingate_connector.image_id

  env = [
    "TWINGATE_NETWORK=${var.twingate_network}",
    "TWINGATE_ACCESS_TOKEN=${var.twingate_api_key}",
    "TWINGATE_REFRESH_TOKEN=${twingate_connector_tokens.local_connector_tokens.refresh_token}",
    "TWINGATE_LABEL_HOSTNAME=${var.twingate_label_hostname}",
    "TWINGATE_LABEL_DEPLOYED_BY=${var.twingate_label_deployed_by}",
  ]

  sysctls = {
    net_ipv4_ping_group_range = "0 2147483647"
  }

  restart = "unless-stopped"

  ports {
    internal = 80
    external = 8080
  }
}
