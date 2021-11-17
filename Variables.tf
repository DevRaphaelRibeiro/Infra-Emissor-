### Define a região
variable "server_region" {
  description = "Region to deploy server"
  type        = string
  default     = "sa-east-1"
}
variable "AWS_REGION_AZ_emissor" {
  default = "sa-east-1a"
}

