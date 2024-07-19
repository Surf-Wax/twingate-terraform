locals {
  docker_compose_file = <<EOF
version: '3.8'
services:
  twingate_connector:
    container_name: ${var.twingate_connector_name}
    restart: unless-stopped
    image: "twingate/connector:latest"
    environment:
      - TWINGATE_NETWORK=${var.twingate_network}
      - TWINGATE_ACCESS_TOKEN=${var.twingate_api_key}
      - TWINGATE_REFRESH_TOKEN=${twingate_connector_tokens.local_connector_tokens.refresh_token}
      - TWINGATE_LOG_ANALYTICS=v2
      - TWINGATE_LOG_LEVEL=3
    sysctls:
      net.ipv4.ping_group_range: "0 2147483647"
EOF
}