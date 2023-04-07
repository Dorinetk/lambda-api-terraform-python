#handle buckect to store the zip file 
resource "random_pet" "lambda_bucket_name" {
  prefix = "lambda"
  length = 2
}

/*
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = random_pet.lambda_bucket_name.id
  force_destroy = true

}
*/
module "lambda_bucket" {
  source      = "./modules/s3"
  bucket_name = random_pet.lambda_bucket_name.id
  /*tags = {
    Environment = "dev"
  }*/
}
resource "aws_s3_bucket_public_access_block" "lambda_bucket" {
  bucket = module.lambda_bucket.name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}