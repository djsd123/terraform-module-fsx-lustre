output "file_system_id" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.id
}

output "file_system_subnet_id" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.subnet_ids
}

output "file_system_security_group_ids" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.security_group_ids
}

output "file_system_vpc_id" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.vpc_id
}

output "file_system_dns_name" {
  value = aws_fsx_lustre_file_system.fsx_filesystem.dns_name
}
