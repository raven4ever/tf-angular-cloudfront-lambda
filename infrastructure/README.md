# AWS CloudFront Signed URLs

This project will create a CloudFront distribution to provide content from a S3 bucket. Access to the content will be restricted using signed URLs.

## Requirements

The minimum Terraform version to run this project is 1.2.

The machine where the Terraform plan is going to be executed must have the following:

- [jq utility](https://stedolan.github.io/jq/)
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- `/bin/bash`

## Configuration

### Terraform Providers

| Name                           | Version |
| ------------------------------ | ------- |
| [aws](#provider_aws)           | ~> 4.0  |
| [external](#provider_external) | ~> 2.0  |
| [local](#provider_local)       | ~> 2.0  |
| [tls](#provider_tls)           | ~> 4.0  |

### Terraform Inputs

| Name                                              | Description                                                                        | Type          | Default                             | Required |
| ------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------- | ----------------------------------- | :------: |
| [date_format](#input_date_format)                 | Date format for URL sign process                                                   | `string`      | `"DD-MM-YYYY"`                      |    no    |
| [s3_bucket_name](#input_s3_bucket_name)           | Name of the bucket where the content is stored                                     | `string`      | `"000-super-important-content-999"` |    no    |
| [tags](#input_tags)                               | Tags to be applied to all created resources                                        | `map(string)` | {<br> "CreatedBy": "Terraform"<br>} |    no    |
| [time_for_url_expire](#input_time_for_url_expire) | Amount of time to be added from current timestamp until the signed URL will expire | `string`      | `"48h"`                             |    no    |

The inputs can be overwritten starting from the [default.tfvars](./default.tfvars) file.

### Terraform Outputs

| Name                                         | Description                               |
| -------------------------------------------- | ----------------------------------------- |
| [distribution_url](#output_distribution_url) | URL to access the CloudFront distribution |
| [kitty_url](#output_kitty_url)               | URL to access the kitty JPEG              |
| [signed_kitty_url](#output_signed_kitty_url) | Signed URL to access the kitty JPEG       |
| [storage_bucket](#output_storage_bucket)     | Storage Bucket regional domain name       |
