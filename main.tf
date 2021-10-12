resource "aws_instance" "ec2" {

  ami           = "ami-"
  instance_type = "t2.micro"
  key_name      = "EC2 Instance"
 
  vpc_security_group_ids = ["sg"]
  subnet_id              = "subnet"

  tags = {
    Name = "EC2 Instance"
  }
}
resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = "5"
}

resource "aws_volume_attachment" "ebs_att" {
  instance_id = aws_db_instance.example.id
  device_name = "/dev/sda1"
  volume_id   = aws_ebs_volume.example.id
}


resource "aws_db_instance" "default" {
  identifier = "mysql-db"
  name              = "testdb"
  allocated_storage = "20"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"


  multi_az = false
  publicly_accessible        = true
  username                   = var.username
  password                   = var.password
  auto_minor_version_upgrade = true
  deletion_protection        = false
  tags = {
    Name = "newdb"
  }
  skip_final_snapshot = true
}
