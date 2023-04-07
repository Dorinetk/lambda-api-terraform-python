output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.returnTimeIP.function_name
}

output "bucket-name" {
  description = "Name (id) of the bucket"
  value       = module.lambda_bucket.name
}

output "api_endpoint" {
  description = "api_endpoint"
  value       = module.aws_apigatewayv2_api_main.api_endpoint
}

output "execution_arn" {
  description = "api execution_arn"
  value       = module.aws_apigatewayv2_api_main.execution_arn 
}

output "returnTimeIP_base_url" {
  value = aws_apigatewayv2_stage.dev.invoke_url
}