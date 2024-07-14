resource "aws_iam_policy" "alb_ingress_policy" {
  name        = var.alb_ingress_policy_name
  path        = "/"
  description = "IAM policy for ALB Ingress Controller"

  policy = file("alb-ingress-policy.json")
}

resource "aws_iam_role" "alb_ingress_role" {
  name = var.alb_ingress_role_name

  # Assume role policy document
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "alb_ingress_policy_attach" {
  role       = aws_iam_role.alb_ingress_role.name
  policy_arn = aws_iam_policy.alb_ingress_policy.arn
}
