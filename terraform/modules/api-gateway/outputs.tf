
output "id" {
  description = "protocol id"
  value       = aws_apigatewayv2_api.main.id
}

output "api_endpoint" {
  description = "api_endpoint"
  value       = aws_apigatewayv2_api.main.api_endpoint
}

output "arn" {
  description = "api arn"
  value       = aws_apigatewayv2_api.main.arn
}

output "execution_arn" {
  description = "api execution_arn"
  value       = aws_apigatewayv2_api.main.execution_arn 
}