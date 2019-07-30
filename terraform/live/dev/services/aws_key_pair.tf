resource "aws_key_pair" "ec2_ssh_keypair" { 
key_name = "mykeypair"
public_key = "${file("../secrets/files/ssh/ec2.ssh.public.pem")}"

}