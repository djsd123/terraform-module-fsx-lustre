variable "name" {
  type    = string
  default = "fsx-test"
}

# NASA's Nex open data bucket
module "fsx_lustre_monitoring" {
  source = "../"

  name                                   = "${var.name}-mon"
  region                                 = "eu-west-1"
  subnet_id                              = "subnet-01234567890abcdefg"
  security_group_ids                     = ["sg-01234567890abcdefg"]
  storage_capacity                       = 7200
  enable_low_storage_capacity_monitoring = true
  enable_backups                         = true
  alarm_notification_email_address       = "rishi.fishi@hustings.wem"
}

module "fsx_lustre_no_monitoring" {
  source = "../"

  name                                   = "${var.name}-nomon"
  region                                 = "eu-west-1"
  subnet_id                              = "subnet-01234567890abcdefg"
  security_group_ids                     = ["sg-01234567890abcdefg"]
  storage_capacity                       = 7200
  enable_low_storage_capacity_monitoring = false
  alarm_notification_email_address       = "liz.bot@hustings.wem"
}
