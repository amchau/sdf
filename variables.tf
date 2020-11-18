variable "placement" {
  description = "placement"
  default     = "PUB"
  type        = string
}

variable "project" {
  description = "project stream name"
  type        = string
  default     = "Stratos"
}
variable "projectStream" {
  description = " 4 character project stream name/code "
  type        = string
}

variable "workStream" {
  description = " 4 character project stream name/code "
  type        = string
}


variable "sku" {
  description = "databricks SKU"
  type        = string
  default     = "standard"
}

variable "region" {
  type        = string
  description = "region. Choose from australia, europe, asia, europe"
}

variable "releaseVersion" {
  description = "releaseVersion"
  default     = "100"
  type        = string
}


variable "owner" {
  description = "owner"
  type        = string
}


variable "environment" {
  description = "Environment. Upto 5 character. For e.g. dev, dev01 , prd01"
  type        = string
}


variable "nameSuffix" {
  description = "Name suffix used for resources"
  type        = string
}

variable "existing_resource_group" {
  description = "existing resource group name"
  type        = string
  default     = ""
}

# Additional tags
variable "additional_tags" {
  description = "Additional set of tags"
  type        = map(string)
  default     = {}
}

# Admins users
variable "admins" {
  description = "List of Admin Users "
  type        = list
  default     = []
}
