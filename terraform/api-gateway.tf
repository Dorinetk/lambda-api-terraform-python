#creating an API gateway using Terraform
/*
resource "aws_apigatewayv2_api" "main" {
  name          = "main"
  protocol_type = "HTTP"
}
*/

module "aws_apigatewayv2_api_main" {
  source   = "./modules/api-gateway"
  name     = "returnTimeIP"
  protocol_type = "HTTP"
}
resource "aws_apigatewayv2_stage" "dev" {
  api_id = module.aws_apigatewayv2_api_main.id

  name        = "dev"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main_api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}


resource "aws_cloudwatch_log_group" "main_api_gw" {
  name = "/aws/api-gw/${module.aws_apigatewayv2_api_main.id}"

  retention_in_days = 14
}