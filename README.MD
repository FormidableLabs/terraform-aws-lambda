[![terraform-aws-lambda — Formidable, We build the modern web](https://raw.githubusercontent.com/FormidableLabs/terraform-aws-lambda/main/terraform-aws-lambda-Hero.png)](https://formidable.com/open-source/)

[![Maintenance Status][maintenance-image]](#maintenance-status)

## Purpose

This module is designed to create uniformly named AWS Lambda resources along with CloudWatch Log Groups and IAM permissions. This module utilizes the the [FormidableLabs/terraform-aws-platform](https://github.com/FormidableLabs/terraform-aws-platform) module to create a _regionally_ identifable Lambda Function Name e.g `use1-production-unsubscriber`

## Example Usage

### Local Zip File

```
module "lambda" {
  source = "github.com/FormidableLabs/terraform-aws-lambda?ref=v0.1"

  filename  = "../../dist/lambda.zip"
  handler   = "build/index.handler"
  service   = var.service
  stage     = var.stage
  variables = {
    STAGE = var.stage
  }
  ...
}
```

### S3 Zip File

```
module "lambda" {
  source = "github.com/FormidableLabs/terraform-aws-lambda?ref=v0.1"

  s3_bucket = "lambda-s3-bucket"
  s3_key    = "lambda.zip"
  handler   = "build/index.handler"
  service   = local.service
  stage     = var.stage
  variables = {
    STAGE = var.stage
  }
  ...
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

| Name                                                        | Source                                           | Version |
| ----------------------------------------------------------- | ------------------------------------------------ | ------- |
| <a name="module_platform"></a> [platform](#module_platform) | github.com/FormidableLabs/terraform-aws-platform | v0.1    |

## Resources

| Name                                                                                                                                                      | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                         | resource    |
| [aws_iam_policy.lambda_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)                                 | resource    |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                 | resource    |
| [aws_iam_role_policy_attachment.lambda_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)             | resource    |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)                                   | resource    |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)          | data source |
| [aws_iam_policy_document.lambda_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)            | data source |

## Inputs

| Name                                                                                             | Description                                                                                                                                                                                                 | Type        | Default        | Required |
| ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | -------------- | :------: |
| <a name="input_filename"></a> [filename](#input_filename)                                        | The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options and image_uri cannot be used.                                                              | `string`    | `null`         |    no    |
| <a name="input_handler"></a> [handler](#input_handler)                                           | (Required) Path to the code entrypoint.                                                                                                                                                                     | `string`    | n/a            |   yes    |
| <a name="input_log_retention_in_days"></a> [log_retention_in_days](#input_log_retention_in_days) | Log retention in number of days.                                                                                                                                                                            | `number`    | `14`           |    no    |
| <a name="input_memory_size"></a> [memory_size](#input_memory_size)                               | Amount of memory to allocate to the lambda function.                                                                                                                                                        | `number`    | `2048`         |    no    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                                     | Namespacing for multiple environments in a single stage                                                                                                                                                     | `string`    | `""`           |    no    |
| <a name="input_policies"></a> [policies](#input_policies)                                        | Additional IAM policies to attach to the lambda's IAM role.                                                                                                                                                 | `list(any)` | `[]`           |    no    |
| <a name="input_publish"></a> [publish](#input_publish)                                           | Enable versioning for this lambda                                                                                                                                                                           | `bool`      | `false`        |    no    |
| <a name="input_runtime"></a> [runtime](#input_runtime)                                           | Runtime the lambda function should use.                                                                                                                                                                     | `string`    | `"nodejs14.x"` |    no    |
| <a name="input_s3_bucket"></a> [s3_bucket](#input_s3_bucket)                                     | The S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. <br> This bucket must reside in the same AWS region where you are creating the Lambda function. | `string`    | `null`         |    no    |
| <a name="input_s3_key"></a> [s3_key](#input_s3_key)                                              | The S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri.                                                                                                | `string`    | `null`         |    no    |
| <a name="input_service"></a> [service](#input_service)                                           | (Required) Name of the service                                                                                                                                                                              | `string`    | n/a            |   yes    |
| <a name="input_stage"></a> [stage](#input_stage)                                                 | (Required) Stage name (eg. development, staging, production)                                                                                                                                                | `string`    | n/a            |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                    | Additional tags to apply to the log group.                                                                                                                                                                  | `map(any)`  | `{}`           |    no    |
| <a name="input_timeout"></a> [timeout](#input_timeout)                                           | Value for the max number of seconds the lambda function will run.                                                                                                                                           | `number`    | `20`           |    no    |
| <a name="input_variables"></a> [variables](#input_variables)                                     | Map of environment variables to set on the lambda.                                                                                                                                                          | `map(any)`  | `{}`           |    no    |

## Outputs

| Name                                                  | Description |
| ----------------------------------------------------- | ----------- |
| <a name="output_lambda"></a> [lambda](#output_lambda) | n/a         |

<!-- END_TF_DOCS -->

[maintenance-image]: https://img.shields.io/badge/maintenance-active-green.svg?color=brightgreen&style=flat

## Maintenance Status

**Active:** Formidable is actively working on this project, and we expect to continue for work for the foreseeable future. Bug reports, feature requests and pull requests are welcome.
