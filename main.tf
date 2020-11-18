

provider "azurerm" {
  version = "=2.5.0"
  features {}
}


terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.2.8"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.workspace_name.id  
}



module "tag" {
  source         = "git::https://sede-ds-adp.visualstudio.com/Platform%20-%20General/_git/sedp-tf-az-tagging?ref=v0.3.2"
  projectStream  = var.projectStream
  workStream     = var.workStream
  environment    = var.environment
  owner          = var.owner
  region         = var.region
  placement      = var.placement
  releaseVersion = var.releaseVersion
}


locals {
  wkstm               = var.workStream == "" ? "" : "-${var.workStream}"  
  resource_group_name = "${var.projectStream}${local.wkstm}-${var.placement}-${var.environment}-${var.releaseVersion}-${lookup(module.tag.region_short, module.tag.location_primary)}-db-rg"  
  workspace_name      = "${var.projectStream}${local.wkstm}-${var.placement}-${var.environment}-${var.releaseVersion}-${lookup(module.tag.region_short, module.tag.location_primary)}-db-ws"  

  kvname              = "${var.projectStream}${local.wkstm}-${var.placement}-${var.environment}"
  kv_resource_gp      = "${var.projectStream}${local.wkstm}-${var.placement}-p-${var.environment}-${var.releaseVersion}-rg"

}

resource "azurerm_resource_group" resource_group_name {
  count    = var.existing_resource_group == "" ? 1 : 0
  name     = upper(local.resource_group_name)
  location = module.tag.location_primary
  tags     = merge(var.additional_tags, module.tag.tags_primary)

  # dynamic tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


data "azurerm_resource_group" resource_group_name {
  count = var.existing_resource_group == "" ? 0 : 1
  name  = var.existing_resource_group
}


#Azure DataBricks Workspace
resource "azurerm_databricks_workspace" workspace_name {
  name                = upper(local.workspace_name)
  resource_group_name = upper(local.resource_group_name)
  location            = module.tag.location_primary
  sku                 = var.sku

  //custom_parameters {
    //no_public_ip        = false
    //virtual_network_id  = azurerm_virtual_network.example.id
    //public_subnet_name  = azurerm_subnet.public.name
    //private_subnet_name = azurerm_subnet.private.name
  //}

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

//create admin user - If admins var is populated
data "databricks_group" "admins" {
  display_name = "admins"
}
 
resource "databricks_user" "me" {
  count    = length(var.admins)
  user_name    = var.admins[count.index]
}

resource "databricks_group_member" "i-am-admin" {
  count    = length(var.admins)
  group_id = data.databricks_group.admins.id
  member_id = databricks_user.me[count.index].id
}
