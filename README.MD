terraform-aws-lambda

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
  service   = local.service
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

[maintenance-image]: https://img.shields.io/badge/maintenance-active-green.svg?color=brightgreen&style=flat

## Maintenance Status

**Active:** Formidable is actively working on this project, and we expect to continue for work for the foreseeable future. Bug reports, feature requests and pull requests are welcome.
