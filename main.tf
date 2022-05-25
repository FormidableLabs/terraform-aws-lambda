locals {
  account_id   = module.platform.account_id
  partition    = module.platform.partition
  region       = module.platform.region
  region_short = module.platform.region_short
  name         = join("-", compact([local.region_short, var.stage, var.namespace, var.service]))

  tags = merge(var.tags, {
    TerraformModule = "lambda"
  })
}

module "platform" {
  # uses the unversioned platform module
  source = "github.com/FormidableLabs/terraform-aws-platform?ref=v0.1"
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${local.name}"

  retention_in_days = var.log_retention_in_days

  tags = local.tags
}

resource "aws_lambda_function" "this" {
  function_name = local.name

  filename    = var.filename
  s3_bucket   = var.s3_bucket
  s3_key      = var.s3_key
  role        = aws_iam_role.this.arn
  runtime     = var.runtime
  handler     = var.handler
  memory_size = var.memory_size
  publish     = var.publish
  timeout     = var.timeout

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = var.variables
  }

  tags = local.tags
}
