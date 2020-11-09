## Introduction 
Terraform module to create databricks Workspace


## Requirements

| Name | Version |
|------|---------|
| azurerm | =2.5.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | =2.5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tags | Additional set of tags | `map(string)` | `{}` | no |
| environment | Environment. Upto 5 character. For e.g. dev, dev01 , prd01 | `string` | n/a | yes |
| existing\_resource\_group | existing resource group name | `string` | `""` | no |
| owner | owner | `string` | n/a | yes |
| sku | databricks sku | `string` | "standard" | yes |
| placement | placement | `string` | `"PUB"` | no |
| project | project stream name | `string` | `"Stratos"` | no |
| projectStream | 4 character project stream name/code | `string` | n/a | yes |
| region | region. Choose from australia, europe, asia, europe | `string` | n/a | yes |
| releaseVersion | releaseVersion | `string` | `"100"` | no |
| workStream | 4 character project stream name/code | `string` | n/a | yes |

## Outputs

No output.

