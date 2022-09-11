# Terraform Module FSx Lustre
[FSx]: https://aws.amazon.com/fsx/lustre/

Terraform AWS module to create an [FSx] Lustre filesystem


[terraform]: https://www.terraform.io/downloads
[hashicorp/aws]: https://registry.terraform.io/providers/hashicorp/aws
[pytest]: https://pypi.org/project/pytest/
[tftest]: https://pypi.org/project/tftest/


## Requirements

| Name            | Version |
|-----------------|---------|
| [terraform]     | ~> 1.2  |
| [hashicorp/aws] | ~> 4.x  |
| [pytest]        | ~> 7.x  |
| [tftest]        | ~> 1.x  |


## Usage

Change directory to fixtures
```shell
cd fixtures
```

Initialise [terraform]
```shell
terraform init
```

Run a plan
```shell
terraform plan
```

Deploy
```shell
terraform apply
```


| Name                                     | Description                                                                                                                                                       | Type           | Default         | Required |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-----------------|:--------:|
| name                                     | Common name for all resources.                                                                                                                                    | `string`       | `""`   |   yes    |
| region                                   | The region to deploy the resources.                                                                                                                               | `string`       | `""`            |   yes    |
| subnet_id                                | The subnet to create the filesystem in.  Note; FSx Lustre only supports one 'availability zone/subnet'.                                                           | `string`       | `""`            |   yes    |
| security_group_ids                       | A list of security group Ids to apply to the filesystem.                                                                                                          | `list(string)` | `""`            |   yes    |
| storage_capacity                         | Storage capacity of file system. See: https://docs.aws.amazon.com/fsx/latest/APIReference/API_CreateFileSystem.html#FSx-CreateFileSystem-request-StorageCapacity. | `number`       | `""`            |   yes    |
| s3_import_path                           | The s3 bucket to use to back your fsx filesystem. Defaults to NASA's Nex open data bucket.                                                                        | `string`       | `s3://nasanex`  |    no    |
| file_system_type_version                 | The Lustre version for the file system.                                                                                                                           | `number`       | `2.12`          |    no    |
| data_compression_type                    | The data compression configuration for the file system. Valid values are 'LZ4' and 'NONE'.                                                                        | `string`       | `NONE`          |    no    |
| storage_type                             | The filesystem storage type. Either SSD or HDD.                                                                                                                   | `string`       | `SSD`           |    no    |
| backup_id                                | The ID of the source backup to create the filesystem from.                                                                                                        | `string`       | `""`            |    no    |
| deployment_type                          | The filesystem deployment type. One of: SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2.                                                                         | `string`       | `SCRATCH_2`     |    no    |
| enable_low_storage_capacity_monitoring   | Whether to enable the dashboard and 'Low free storage capacity alarm'?                                                                                            | `bool`         | `false`         |    no    |
| low_free_data_storage_capacity_threshold | Low free data storage capacity threshold (Bytes).                                                                                                                 | `string`       | `7100000000000` |    no    |
| alarm_notification_email_address         | The email address to send FSX storage alarms/alerts to.                                                                                                           | `string`       | `""`            |   yes    |


## Outputs

| Name                         | Description                                              |
|------------------------------|----------------------------------------------------------|
| file_system_id               | The id of the FSx filesystem.                            |
| file_system_security_group_ids     | The security group ids for the filesystem security group. |
| file_system_subnet_id              | The id of the subnet associated with the FSx filesystem. |
| file_system_vpc_id               | The vpc id of the FSx filesystem.                        |
| file_system_dns_name               | The dns name of the FSx filesystem.                      |


### Testing

**Note**
You can produce/create a plan to assist you in writing your tests by running the following:

Change directory to fixtures
```shell
cd fixtures
```

Create a plan file
```shell
terraform plan -out plan.tfplan
```

Create a non-binary plan file
```shell
terraform show -json plan.tfplan > plan.json
```

#### Unit Tests

There is a small set of unit tests defined in [test-module-fsx-lustre-monitoring.py](test-module-fsx-lustre-monitoring.py) to test the conditional logic in this
[Terraform] module. These tests run automatically when a pull request is created in this repo.

To run the tests locally

1. Create/Activate a [virtual environment](https://docs.python.org/3/tutorial/venv.html)

2. Execute the test runner

```shell
python -m pytest test-module-fsx-lustre-monitoring.py
```
