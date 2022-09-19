variable "name" {
  type        = string
  description = "Common name for all resources"
}

variable "region" {
  type        = string
  description = "The region to deploy the resources"
}

variable "vpc_id" {
  type        = string
  description = "The Id of the vpc to deploy the filesystem into"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to create the filesystem in.  Note; FSx Lustre only supports one 'availability zone/subnet'"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group Ids to permit access to the filesystem."
}

variable "storage_capacity" {
  type        = number
  description = "Storage capacity of file system. See: https://docs.aws.amazon.com/fsx/latest/APIReference/API_CreateFileSystem.html#FSx-CreateFileSystem-request-StorageCapacity"
}

variable "s3_import_path" {
  type        = string
  description = "The s3 bucket to use to back your fsx filesystem. Defaults to NASA's Nex open data bucket"

  default = "s3://nasanex"
}

variable "file_system_type_version" {
  type        = number
  description = "The Lustre version for the file system."

  default = 2.12
}

variable "data_compression_type" {
  type        = string
  description = "The data compression configuration for the file system. Valid values are 'LZ4' and 'NONE'"

  default = "NONE"
}

variable "storage_type" {
  type        = string
  description = "The filesystem storage type. Either SSD or HDD."

  default = "SSD"
}

variable "backup_id" {
  type        = string
  description = "The ID of the source backup to create the filesystem from."

  default = ""
}

variable "deployment_type" {
  type        = string
  description = "The filesystem deployment type. One of: SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2."

  default = "SCRATCH_2"
}

variable "enable_low_storage_capacity_monitoring" {
  type        = bool
  description = "Whether to enable the dashboard and 'Low free storage capacity alarm'?"

  default = false
}

variable "low_free_data_storage_capacity_threshold" {
  type        = string
  description = "Low free data storage capacity threshold (Bytes)"

  default = "7100000000000"

  validation {
    condition     = length(regexall("^[0-9]+$", var.low_free_data_storage_capacity_threshold)) == 1
    error_message = "Value must contain number only as a string"
  }
}

variable "alarm_notification_email_address" {
  type        = string
  description = "The email address to send FSX storage alarms/alerts to"
}

variable "enable_backups" {
  type        = bool
  description = "Whether to enable backups for this filesystem"

  default = false
}
