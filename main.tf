# Define AWS providers for US and EU regions
provider "aws" {
  alias  = "us"
  region = "us-east-1"  # Replace with your desired US region
}

provider "aws" {
  alias  = "eu"
  region = "eu-west-1"  # Replace with your desired EU region
}

# Generate SSH Key Pairs
resource "aws_key_pair" "us_key" {
  provider   = aws.us
  key_name   = "us-key"
  public_key = file("/home/ec2-user/.ssh/id_rsa.pub")  # Corrected Path
}

resource "aws_key_pair" "eu_key" {
  provider   = aws.eu
  key_name   = "eu-key"
  public_key = file("/home/ec2-user/.ssh/id_rsa.pub")  # Corrected Path
}

# Create an EC2 instance in the US region
resource "aws_instance" "us_instance" {
  provider      = aws.us
  ami           = "ami-032ae1bccc5be78ca"  # Replace with correct AMI ID for US region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.us_key.key_name

  tags = {
    Name = "US-Instance"
  }
}

# Create an EC2 instance in the EU region
resource "aws_instance" "eu_instance" {
  provider      = aws.eu
  ami           = "ami-00410d8a184b40e78"  # Replace with correct AMI ID for EU region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.eu_key.key_name

  tags = {
    Name = "EU-Instance"
  }
}

