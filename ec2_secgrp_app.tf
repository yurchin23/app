#====================================================================
#
#                       First Terraform Build
#   Task : Create Instance AWS with EC2 and Security Group service ->
#          and install on this Instance - Jenkins software         ->
#          ok. lets GO!
#
#                 Course curator  : Vitalii Perminov
#                 Author          : Daniil Yurchin
#                 Used sources    : Youtube Chanel - ADV-IT
#
#====================================================================


provider "aws" {
    region = "eu-central-1"                                           # Frankfurt
}

resource "aws_instance" "homework" {                                  # Amazon Instance
  ami                       =   "ami-0767046d1677be5a0"               # Amazon Ubuntu AMI
  instance_type             =   "t2.micro"                            # Tariff type
  vpc_security_group_ids    =   [aws_security_group.homework.id]      # Dependenc Instance and Security Group
  user_data                 =   file("web-app.sh")                    # Script  
  key_name                  =   "main_ssh"			                      # SSH KEY
  
  connection {                                                        # SSH connections to my Instance
    type        = "ssh" 
    user        = "ubuntu"
    private_key = file("~/project/studying/COURSE/secret/main_ssh")
    host        = self.public_ip                                      # Instance Public IP
  }
  
provisioner "file" {
    source      = "~/project/studying/COURSE/docker/app/"
    destination = "/home/ubuntu/"
  }

provisioner "file" {                                                  # Copies "web-app.sh" to folder tmp
   source      = "~/project/studying/COURSE/docker/app/web-app.sh"                                  
   destination = "/tmp/web-app.sh"
  }

provisioner "remote-exec" {                                           # Invoke a script on a remote resource after it is created
    inline = [                                                        # Tag for call web-app.sh
      "chmod +x /tmp/web-app.sh",                              
      "sudo /tmp/web-app.sh",
    ]
  }
tags = {
 Name = "Web APP Build by Terraform"
 Owner = "Daniil Yurchin"
}
}

resource "aws_security_group" "homework" {                            # Amazon Security Group
  name        = "WebServer Security Group"
  description = "Allow Port 8080 TCP inbound traffic"

  ingress {                                                           # IN (WEB-APP)
    from_port   = 3000                                                # Allow connection from port 3000 
    to_port     = 3000                                                # Allow connection to port 3000  
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                                       # Allow all connection
  }

  ingress {                                                           # IN 
    from_port   = 22                                                  # Allow connection from port 22 
    to_port     = 22                                                  # Allow connection to port 22  
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                                       # Allow all connection
  }

  egress {                                                            # OUT
    from_port   = 0                                                   # ALL OUT
    to_port     = 0                                                   # ALL OUT
    protocol    = "-1"                                                # ALL OUT
    cidr_blocks = ["0.0.0.0/0"]                                       # ALL OUT
  }

  tags = {
 Name = "Web Server Build by Terraform"
 Owner = "Daniil Yurchin"
}
}
