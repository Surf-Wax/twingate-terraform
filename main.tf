terraform {
    required_providers {
        twingate = {
            source = "Twingate/twingate"
            version = "3.0.6"
        }
    }
}

provider "twingate" {
    api_token = 
}

