resource "aws_s3_bucket" "sse_s3" {
  bucket = "reireias.sse.s3"
  acl    = "public-read"

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

resource "aws_s3_bucket" "sse_c" {
  bucket = "reireias.sse.c"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  force_destroy = true
}
