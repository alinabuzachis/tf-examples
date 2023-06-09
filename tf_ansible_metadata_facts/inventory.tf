resource "local_file" "private_key" {
  sensitive_content = tls_private_key.ec2_key.private_key_pem
  filename          = format("%s/%s/%s", abspath(path.root), ".ssh", "${var.key_pair_name}.pem")
  file_permission = "600"
  directory_permission = "700"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
      ip          = aws_instance.server.public_ip,
      ssh_keyfile = local_file.private_key.filename
  })
  filename = format("%s/%s", abspath(path.root), "inventory.yaml")
}
