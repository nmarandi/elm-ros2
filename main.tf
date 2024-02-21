

provider "aws" {
}

resource "aws_ecr_repository" "elm_ros2_repository" {
  name                 = "elm-ros2-repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_iam_role" "ecr_read_role" {
  name = "ECRReadRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecr_read_policy" {
  name        = "ECRReadPolicy"
  description = "Allows read access to ECR repositories"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecr_read_attachment" {
  role       = aws_iam_role.ecr_read_role.name
  policy_arn = aws_iam_policy.ecr_read_policy.arn
}

resource "aws_iam_instance_profile" "ecr_read_profile" {
  name = "ecr_read_profile"
  role = aws_iam_role.ecr_read_role.name
}

resource "aws_instance" "elm_ros2_server" {
  ami           = "ami-05fb0b8c1424f266b"
  instance_type = "t2.micro"

  tags = {
    Name = "ElmROS2"
  }
  iam_instance_profile = aws_iam_instance_profile.ecr_read_profile.name
  user_data = "${file("setupec2.sh")}"
  key_name = "ssh"
}