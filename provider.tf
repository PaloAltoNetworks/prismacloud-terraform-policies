terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = "1.5.6"
    }
  }
}


provider "prismacloud" {
  #features {}
  json_config_file = "creds.json"
}
