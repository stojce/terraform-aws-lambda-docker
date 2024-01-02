<!-- BEGIN_TF_DOCS -->

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

[![Terraform](https://github.com/crayon/terraform-aws-template/actions/workflows/ci.yml/badge.svg)](https://github.com/crayon/terraform-aws-template/actions/workflows/ci.yml)

# AWS terraform module for

## Architectural Diagram
![Architecture](./docs/architecture.drawio.svg "Architecture")

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4, <6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3 |

## Example
```hcl

```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4, <6 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_image_url"></a> [ecr\_image\_url](#input\_ecr\_image\_url) | (Optional) docker image URL | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Value to use as a suffix in resource names and provide uniquness. E.g. 'dev', 'prod', 'test', etc. | `string` | n/a | yes |
| <a name="input_extra_policy_statements"></a> [extra\_policy\_statements](#input\_extra\_policy\_statements) | Additional policy statements to be added to the Lambda execution policy. | `list(any)` | `[]` | no |
| <a name="input_lambda_environment_variables"></a> [lambda\_environment\_variables](#input\_lambda\_environment\_variables) | (optional) Environment variables for Lambda functions | `map(any)` | `null` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | Memory size for Lambda functions | `number` | `128` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | Timeout for Lambda functions | `number` | `6` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_override_command"></a> [override\_command](#input\_override\_command) | override CMD command od the docker image | `string` | `null` | no |
| <a name="input_override_directory"></a> [override\_directory](#input\_override\_directory) | override WORKDIR command od the docker image | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (optional) Security groups where Lambda function will be set ('sg-xxxxxxxx') | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (optional) Subnets where Lambda function will be set ('subnet-xxxxxxxx') | `set(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (optional) VPC ID | `string` | n/a | yes |

## Outputs

No outputs.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.extra_pipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_security_group.lambda_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.lambda_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Resources Graph
![Resources Graph](./docs/graph.svg "Resources Graph")
<!-- END_TF_DOCS -->