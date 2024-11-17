


##### Below is the user data file ####################

data "template_file" "temp_init" {
  template = file("${path.module}/myfile.tpl")
}

######## AWS EC2 instance code   ####################

resource "aws_instance" "my-test-machine" {
  count                  = 2
  ami                    = data.aws_ami.Amazon_images.image_id
  instance_type          = var.aws_instance_type
  key_name               = "BU01_dev_key"
  subnet_id              = element(var.pub_subnet, count.index)
  vpc_security_group_ids = var.security_group
  user_data              = data.template_file.temp_init.rendered

  tags = {
    Name        = "testmachine00${count.index + 1}"
    environment = "Development"
  }

  lifecycle {
    ignore_changes = [ami]
  }

  root_block_device {
    encrypted = "false"
    volume_size = "8"
    volume_type = "gp2"
  }

}
