name = "kitchen-default-s3"

bucket_prefix        = "prefix-example-s3"
bucket_name_override = "kitchen-override-example-s3"

tags = {
  environment = "dev"
  terraform   = "true"
  kitchen     = "true"
}
