resource "aws_s3_bucket" "no_sse" {
  bucket = "reireias.sse.none"
  acl    = "public-read"
  policy = templatefile("files/bucket_policy_template.json", {
    bucket_name = "reireias.sse.none"
  })

  website {
    index_document = "index.html"
  }

  force_destroy = true
}

resource "aws_s3_bucket" "sse_s3" {
  bucket = "reireias.sse.s3"
  acl    = "public-read"
  policy = templatefile("files/bucket_policy_template.json", {
    bucket_name = "reireias.sse.s3"
  })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
  }

  force_destroy = true
}

resource "aws_s3_bucket" "sse_kms" {
  bucket = "reireias.sse.kms"
  acl    = "public-read"
  policy = templatefile("files/bucket_policy_template.json", {
    bucket_name = "reireias.sse.kms"
  })

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3_key.arn
      }
    }
  }

  website {
    index_document = "index.html"
  }

  force_destroy = true
}
