/**
* # AWS terraform module for
*
*
* ## Architectural Diagram
* ![Architecture](./docs/architecture.drawio.svg "Architecture")
*/


terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4, <6"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3"
    }
  }
}
