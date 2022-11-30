output "lambda" {
  value = aws_lambda_function.this
}

output "arn" {
  value = aws_lambda_function.this.arn
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}
