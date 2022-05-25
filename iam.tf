data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    resources = [
      "arn:${local.partition}:logs:${local.region}:${local.account_id}:log-group:/aws/lambda/${local.name}*"
    ]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "cloudwatch:PutMetricData"
    ]
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name   = "${local.name}-lambda-execution"
  policy = data.aws_iam_policy_document.lambda_execution.json
}

resource "aws_iam_role" "this" {
  name               = "${local.name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.this.id
  policy_arn = aws_iam_policy.lambda_execution.arn
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policies)

  role       = aws_iam_role.this.id
  policy_arn = each.value
}
