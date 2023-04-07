resource "aws_apigatewayv2_api" "main" {
  name          = var.name
  protocol_type = var.protocol_type
}

