terraform {
  cloud {
    organization = "your_organizaion"

    workspaces {
      name = "your_workspace"
    }
  }
}