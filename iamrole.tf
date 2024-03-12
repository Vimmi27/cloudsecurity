# Create an IAM role
resource "aws_iam_role" "vimmic_role" {
  name               = "vimmic"
  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [
      {
        "Effect"    : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action"    : "sts:AssumeRole"
      }
    ]
  })
}


# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "my_attachment" {
  role       = aws_iam_role.vimmic_role.name
  policy_arn = aws_iam_policy.vimmic_policy.arn
}