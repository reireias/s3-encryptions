# s3-encryptions
Examples of Amazon S3 encryption settings and download path.

## setup
Create resources with Terraform.

```
$ terraform init
$ terraform apply
```

Upload objects.

```
$ aws s3 cp files/index.html s3://reireias.sse.none/
$ aws s3 cp files/index.html s3://reireias.sse.s3/
$ aws s3 cp files/index.html s3://reireias.sse.kms/
```

## Check download
### S3 Static Website

```
$ curl http://reireias.sse.none.s3-website-ap-northeast-1.amazonaws.com/
#=> OK

$ curl http://reireias.sse.s3.s3-website-ap-northeast-1.amazonaws.com/
#=> OK

$ curl http://reireias.sse.kms.s3-website-ap-northeast-1.amazonaws.com/
#=> Error
```

### Get Object URL

```
$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.none/index.html
#=> OK

$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.s3/index.html
#=> OK

$ curl https://s3-ap-northeast-1.amazonaws.com/reireias.sse.kms/index.html
#=> Error
```
