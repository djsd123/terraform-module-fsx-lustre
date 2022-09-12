import pytest
import tftest

envs = {
    'AWS_REGION': 'eu-west-1'
}

@pytest.fixture
def plan(fixtures_dir, terraform_binary):
    tf = tftest.TerraformTest(tfdir=fixtures_dir, binary=terraform_binary, env=envs)
    # tf.init()
    return tf.plan(output=True)


sns_topic = 'aws_sns_topic.alarm_notification[0]'
sns_topic_subscription = 'aws_sns_topic_subscription.alarm_email_subscription[0]'
cloudwatch_dashboard = 'aws_cloudwatch_dashboard.fsx_filesystem_dashboard[0]'
cloudwatch_metric_alarm = 'aws_cloudwatch_metric_alarm.fsx_storage_capacity_alarm[0]'
fsx_filesystem_backup = 'aws_fsx_backup.fsx_filesystem_backup[0]'


"""
Testing monitoring resources exist when Terraform variable: 'enable_low_storage_capacity_monitoring'
is set to 'true'.
"""
def test_enable_low_storage_capacity_monitoring(plan):
    module_enable_monitoring = plan.modules['module.fsx_lustre_monitoring']
    try:
        module_enable_monitoring.resources[sns_topic]
        module_enable_monitoring.resources[sns_topic_subscription]
        module_enable_monitoring.resources[cloudwatch_dashboard]
        module_enable_monitoring.resources[cloudwatch_metric_alarm]
    except KeyError:
        pytest.fail(KeyError)

#
# """
# Testing no monitoring resources are created when Terraform variable: 'enable_low_storage_capacity_monitoring'
# is set to 'false'.
# """
# def test_enable_low_storage_capacity_no_monitoring(plan):
#     module_disable_monitoring = plan.modules['module.fsx_lustre_no_monitoring']
#     with pytest.raises(KeyError):
#         module_disable_monitoring.resources[sns_topic]
#         module_disable_monitoring.resources[sns_topic_subscription]
#         module_disable_monitoring.resources[cloudwatch_dashboard]
#         module_disable_monitoring.resources[cloudwatch_metric_alarm]
#
#
# """
# Testing backup resource is created when Terraform variable: 'enable_backups'
# is set to 'true'.
# """
# def test_enable_backups_creates_backup_resource_monitoring(plan):
#     module_enable_monitoring = plan.modules['module.fsx_lustre_monitoring']
#     try:
#         module_enable_monitoring.resources[fsx_filesystem_backup]
#     except KeyError:
#         pytest.fail(KeyError)
#
#
# """
# Testing no backup resource is created when Terraform variable: 'enable_backups'
# is set to 'false'.
# """
# def test_enable_backups_not_creating_backup_resource_no_monitoring(plan):
#     module_enable_monitoring = plan.modules['module.fsx_lustre_no_monitoring']
#     with pytest.raises(KeyError):
#         module_enable_monitoring.resources[fsx_filesystem_backup]
