# Creating 1st EC2 instance in Public Subnet
resource "aws_instance" "instance1" {
  ami                         = "ami-087c17d1fe0178315"
  instance_type               = "t2.micro"
  key_name                    = "tests"
  vpc_security_group_ids      = ["${aws_security_group.web-sg.id}"]
  subnet_id                   = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true
  user_data                   = file("data.sh")
  tags = {
    Name = "My Public Instance"
  }


 provisioner "file" {
    source = "./tests.pem"
    destination = "/home/khanansCI/tests.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "khanansCI"
      private_key = "${file("./tests.pem")}"
    }  
  }
}

# Creating 2nd EC2 instance in Public Subnet
resource "aws_instance" "instance2" {
  ami                         = "ami-087c17d1fe0178315"
  instance_type               = "t2.micro"
  key_name                    = "tests"
  vpc_security_group_ids      = ["${aws_security_group.web-sg.id}"]
  subnet_id                   = aws_subnet.public-subnet-2.id
  associate_public_ip_address = true
  user_data                   = file("data.sh")
  tags = {
    Name = "My Public Instance 2"
  }
}