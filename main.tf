

provider "aws" {
}

resource "aws_instance" "elm_ros2_server" {
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"

  tags = {
    Name = "ElmROS2"
  }

  user_data = "${file("setupros2.sh")}"
  key_name = "ssh"
}