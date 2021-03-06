# s3-encryptions
Examples of Amazon S3 encryption settings and download path.

## setup
Create resources with Terraform.

```console
$ terraform init
$ terraform apply
```

Upload objects.

```console
$ aws s3 cp files/index.html s3://reireias.sse.none/
$ aws s3 cp files/index.html s3://reireias.sse.s3/
$ aws s3 cp files/index.html s3://reireias.sse.kms/

# for CloudFront
$ aws s3 cp files/index.html s3://reireias.sse.s3/sse_s3/
$ aws s3 cp files/index.html s3://reireias.sse.kms/sse_kms/
```

Check encryption status.

```console
$ aws s3api head-object --bucket reireias.sse.none --key index.html
#=> No encryption

$ aws s3api head-object --bucket reireias.sse.s3 --key index.html
#=> "ServerSideEncryption": "AES256",

$ aws s3api head-object --bucket reireias.sse.kms --key index.html
#=> "ServerSideEncryption": "aws:kms",
#=> "SSEKMSKeyId": "arn:aws:kms:ap-northeast-1:xxxxxxxxxx:key/xxxxxxxxxxxxxxxxx"
```

## Check download
### S3 Static Website

```console
$ curl http://reireias.sse.none.s3-website-ap-northeast-1.amazonaws.com/
#=> OK

$ curl http://reireias.sse.s3.s3-website-ap-northeast-1.amazonaws.com/
#=> OK

$ curl http://reireias.sse.kms.s3-website-ap-northeast-1.amazonaws.com/
#=> Error
```

### Object URL

```console
$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.none/index.html
#=> OK

$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.s3/index.html
#=> OK

$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.kms/index.html
#=> Error
```

### Presigned URL
Set default signature version to SigV4.

```console
$ aws configure set default.s3.signature_version s3v4
```

```console
$ curl $(aws s3 presign s3://reireias.sse.none/index.html)
#=> OK

$ curl $(aws s3 presign s3://reireias.sse.s3/index.html)
#=> OK

$ curl $(aws s3 presign s3://reireias.sse.kms/index.html)
#=> OK
```

### CloudFront

```console
$ curl https://$(terraform output cloudfront_domain)/index.html
#=> OK

$ curl https://$(terraform output cloudfront_domain)/sse_s3/index.html
#=> OK

$ curl https://$(terraform output cloudfront_domain)/sse_kms/index.html
#=> Error
```
