# creates a role for the lambda function
# use an iam module ???
resource "aws_iam_role" "returnTimeIP_lambda_exec" {
  name = "returnTimeIP-lambda"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "returnTimeIP_lambda_policy" {
  role       = aws_iam_role.returnTimeIP_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# creates a resource for the lambda function
resource "aws_lambda_function" "returnTimeIP" {
  function_name = "returnTimeIP"

  s3_bucket = module.lambda_bucket.name
  s3_key    = aws_s3_bucket_object.lambda_returnTimeIP.key

  runtime = "python3.8"
  handler = "returnTimeIP.handler"

  source_code_hash = data.archive_file.lambda_returnTimeIP.output_base64sha256

  role = aws_iam_role.returnTimeIP_lambda_exec.arn
}


#use module
resource "aws_cloudwatch_log_group" "returnTimeIP" {
  name = "/aws/lambda/${aws_lambda_function.returnTimeIP.function_name}"

  retention_in_days = 14
}

data "archive_file" "lambda_returnTimeIP" {
  type = "zip"

  source_dir  = "../${path.module}/python"
  output_path = "../${path.module}/returnTimeIP.zip"
}

resource "aws_s3_bucket_object" "lambda_returnTimeIP" {
  bucket = module.lambda_bucket.name #aws_s3...

  key    = "returnTimeIP.zip"
  source = data.archive_file.lambda_returnTimeIP.output_path

  etag = filemd5(data.archive_file.lambda_returnTimeIP.output_path)
}
