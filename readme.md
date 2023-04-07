# Prompt
The purpose of this exercise is to create a module that deploys independent resources (i.e., if you call the same module twice in your root, there should be no conflicts based on the module inputs)

Create a system which will return the current time and the IP address of the requestor. The system should only be publicly accessible via a public API endpoint. The system should only return the required data for GET requests. All other request methods should result in some sort of error.

You should use an API Gateway and a Lambda function running the python runtime. Your module should deploy and configure all resources required (Log groups, IAM, etc.)

## elements
modules for required resources
return current time : timestamp() function in python
IP address of requestor
accessible via public API endpoint
return GET request date
through an error for other methods: PUT,POST,PATCH,DELETE
Use API Gateway and Lambda for python runtime

## summary
deploy into a lambda, a python function that returns current time and IP address of the requestor, and expose the function to the internet through API Gateway. Accept only GET method and through an error for any other method. Use modules in Terraform code.

### steps
#https://developer.hashicorp.com/terraform/tutorials/aws/lambda-api-gateway 

step1: create a python function that get time and IP address
Note: isssues with request url method

step2: create lambda function with terraform: everything needed for the lambda: build, package as zip, upload to s3, lambda that points to zip in S3

run terraform workflow to create the function
verify on console
invoke lambda with:
aws lambda invoke --region=us-east-1 --function-name=returnTimeIP response.json
got 200 - success
cat response.json  ###issues with handler

step3: create module for the resources needed: s3 (done), Cloudwatch Logs, API-Gateway, and re-organize the code

step4: create API gateway using Terraform
api-gateway.tf

step5: Integrate API to Lambda
returnTimeIP-api-gateway.tf
test with: 
curl "https://qht8kc5g57.execute-api.us-east-1.amazonaws.com/dev/returnTimeIP?" ##??

Step6: Create Lambda Function with Dependencies & Access to S3 Bucket







