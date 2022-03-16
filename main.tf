resource "null_resource" "omniverse" {


count = var.lab == "omniverse" ? 1 : 0

  connection {
    type        = "ssh"
    user        = "jritenour"
    password = "NULL"
    host        = "127.0.0.1"
  }

  provisioner "file" {
    source     = "ailp-nvidia-ai-enterprise/playbooks"
    destination = "/tmp"
  }

  provisioner "file" {
    content  = "127.0.0.1 ansible_user=jritenour"
    destination = "/tmp/playbooks/inventory"
  }

  provisioner "file" {
    content = "test: var"
    destination = "/tmp/playbooks/vars.yaml"
 }

  provisioner "remote-exec" {
    inline = ["ansible-playbook -i /tmp/playbooks/inventory /tmp/playbooks/site.yaml -e @/tmp/playbooks/vars.yaml"]
  }

}
