## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.42.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.42.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/default_security_group) | resource |
| [aws_eip.nat_eip_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/eip) | resource |
| [aws_eip.nat_eip_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/eip) | resource |
| [aws_flow_log.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/flow_log) | resource |
| [aws_internet_gateway.tf_igw](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.nat_gw_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.tf_private_rt_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table) | resource |
| [aws_route_table.tf_private_rt_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table) | resource |
| [aws_route_table.tf_public_rt](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/subnet) | resource |
| [aws_subnet.private_subnet_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_1a](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_1b](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/subnet) | resource |
| [aws_vpc.terraform_vpc](https://registry.terraform.io/providers/hashicorp/aws/6.42.0/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Nome do bucket S3 usado para backend e Flow Logs | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | n/a |
| <a name="output_private_subnet_1a_id"></a> [private\_subnet\_1a\_id](#output\_private\_subnet\_1a\_id) | n/a |
| <a name="output_private_subnet_1b_id"></a> [private\_subnet\_1b\_id](#output\_private\_subnet\_1b\_id) | n/a |
| <a name="output_public_subnet_1a_id"></a> [public\_subnet\_1a\_id](#output\_public\_subnet\_1a\_id) | n/a |
| <a name="output_public_subnet_1b_id"></a> [public\_subnet\_1b\_id](#output\_public\_subnet\_1b\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID da VPC |
