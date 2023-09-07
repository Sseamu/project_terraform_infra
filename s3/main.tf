#S3 버킷
# 위치 : s3 > 버킷
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "philoberry-s3" {
  bucket = var.bucket //버킷 이름

  tags = {
    Name    = "philoberry-front-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}


// 버킷을 해제해주는 풀어주는 작업(퍼블릭 액세스 제한)
resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.philoberry-s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "philoberry-s3-private" {
  bucket = aws_s3_bucket.philoberry-s3.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.philoberry-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}


# 버킷 정책(acl)
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.philoberry-s3.id

  depends_on = [
    aws_s3_bucket_public_access_block.public-access
  ]

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
       "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        ],
      "Resource":["arn:aws:s3:::${aws_s3_bucket.philoberry-s3.id}/*"],
      "Principal": {
        "AWS": ["arn:aws:iam::874509284256:user/philoberry-iam-prod"]
      
    }
  ]
}
POLICY
}


//정적 웹 호스팅
resource "aws_s3_bucket_website_configuration" "philoberry-s3" {
  bucket = aws_s3_bucket.philoberry-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
