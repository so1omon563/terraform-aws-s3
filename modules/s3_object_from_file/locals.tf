locals {
  tags                   = var.tags
  server_side_encryption = var.default_master_key == false ? "AES256" : "aws:kms" # sets the type of server side encryption
}
