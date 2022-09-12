# foo bar

resource "aws_fsx_lustre_file_system" "fsx_filesystem" {
  import_path              = var.s3_import_path
  storage_capacity         = var.storage_capacity
  security_group_ids       = var.security_group_ids
  subnet_ids               = [var.subnet_id]
  file_system_type_version = var.file_system_type_version
  data_compression_type    = var.data_compression_type
  storage_type             = var.storage_type
  backup_id                = var.backup_id
  deployment_type          = var.deployment_type
  copy_tags_to_backups     = true

  tags = {
    Name = var.name
  }
}

resource "aws_fsx_backup" "fsx_filesystem_backup" {
  count          = var.enable_backups ? 1 : 0
  file_system_id = aws_fsx_lustre_file_system.fsx_filesystem.id
}
