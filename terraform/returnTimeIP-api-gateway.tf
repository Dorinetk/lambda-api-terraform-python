
resource "aws_apigatewayv2_integration" "lambda_returnTimeIP" {
  api_id = module.aws_apigatewayv2_api_main.id

  integration_uri    = aws_lambda_function.returnTimeIP.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}


resource "aws_apigatewayv2_route" "get_returnTimeIP" {
  api_id = module.aws_apigatewayv2_api_main.id

  route_key = "GET /returnTimeIP"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_returnTimeIP.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.returnTimeIP.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.aws_apigatewayv2_api_main.execution_arn}/*/*"
}
