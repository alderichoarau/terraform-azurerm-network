# terraform-azurerm-network

Terraform module that provisions a VNet with a frontend and backend subnet, each protected by its own NSG.

- `subnet-frontend` allows inbound traffic on `frontend_allowed_ports` from the internet, denies everything
  else.
- `subnet-backend` only allows inbound traffic from `subnet-frontend`, denies everything else.

## Usage

```hcl
module "network" {
  source = "github.com/alderichoarau/terraform-azurerm-network"

  name                 = "my-project"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location

  tags = {
    owner = "my-team"
  }
}
```

See [examples/basic](examples/basic) for a complete, runnable example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.9 |
| azurerm | ~> 4.0 |

## Providers

| Name | Version |
| ---- | ------- |
| azurerm | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_network_security_group.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.backend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.frontend](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| address\_space | Address space of the VNet | `list(string)` | <pre>[<br/>  "10.0.0.0/16"<br/>]</pre> | no |
| backend\_subnet\_prefix | Address prefix of subnet-backend | `list(string)` | <pre>[<br/>  "10.0.2.0/24"<br/>]</pre> | no |
| frontend\_allowed\_ports | TCP ports allowed inbound from the internet on subnet-frontend | `list(string)` | <pre>[<br/>  "80",<br/>  "443"<br/>]</pre> | no |
| frontend\_subnet\_prefix | Address prefix of subnet-frontend | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| location | Azure region for the VNet, subnets and NSGs | `string` | n/a | yes |
| name | Base name used to build the VNet and NSG resource names (e.g. vnet-<name>, nsg-frontend-<name>) | `string` | n/a | yes |
| resource\_group\_name | Name of the Resource Group to deploy into | `string` | n/a | yes |
| tags | Tags applied to all resources in this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| nsg\_backend\_name | Name of the NSG attached to subnet-backend |
| nsg\_frontend\_name | Name of the NSG attached to subnet-frontend |
| subnet\_backend\_id | ID of subnet-backend |
| subnet\_frontend\_id | ID of subnet-frontend |
| vnet\_id | ID of the VNet |
| vnet\_name | Name of the VNet |
<!-- END_TF_DOCS -->

## Notes

- Default CIDRs (`10.0.0.0/16` / `10.0.1.0/24` / `10.0.2.0/24`) collide if you deploy this module more than
  once into the same peered network — override `address_space`, `frontend_subnet_prefix` and
  `backend_subnet_prefix` when that matters.

## Local Git hooks

A [`.pre-commit-config.yaml`](.pre-commit-config.yaml) runs `terraform fmt`, `terraform validate`,
`tflint` and `terraform-docs` before each commit. One-time setup:

```bash
pip install pre-commit   # or: brew install pre-commit
pre-commit install
```

## Contributing

This repository does not accept external contributions. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

All rights reserved. See [LICENSE](LICENSE).
