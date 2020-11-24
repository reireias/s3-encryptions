resource "aws_kms_key" "s3_key" {
  description             = "This key is used to encrypt bucket objects"
}
