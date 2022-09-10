resource "aws_sns_topic" "alarm_notification" {
  count        = var.enable_low_storage_capacity_monitoring ? 1 : 0
  name         = "${aws_fsx_lustre_file_system.fsx_filesystem.id}-alarm-notification"
  display_name = "${aws_fsx_lustre_file_system.fsx_filesystem.id}-alarm-notification"
}

resource "aws_sns_topic_subscription" "alarm_email_subscription" {
  count     = var.enable_low_storage_capacity_monitoring ? 1 : 0
  endpoint  = var.alarm_notification_email_address
  protocol  = "email"
  topic_arn = join("", aws_sns_topic.alarm_notification[*].arn)
}
