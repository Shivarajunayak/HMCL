module "s3_bucket" {
  source = "./aws-s3"

  create_bucket = try(var.create_bucket, false)
  bucket        = var.bucket
  acl           = var.acl

  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  versioning = var.versioning

  tags = var.tags

}



####S3 Object Sample zip for lambda source buckets####
module "s3_object" {

  source = "./aws-s3/modules/object"

  is_lambda_code_bucket = try(var.is_lambda_code_bucket, false)

  bucket = module.s3_bucket.s3_bucket_id
  key    = "my-function.zip"

  file_source = "${path.module}/sample-lambda-zip/my-function.zip"
}
