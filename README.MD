terraform-aws-lambda

## Typical Usage

```
module "lambda" {
  source = "github.com/FormidableLabs/terraform-aws-lambda?ref=v0.1"

  filename = "../../dist/lambda.zip"
  handler  = "build/index.handler"
  service  = local.service
  stage    = var.stage
  variables = {
    STAGE = var.stage
  }
}
```
