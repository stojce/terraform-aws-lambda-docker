locals {
  override_directory = var.override_directory == null ? null : "/var/task/${var.override_directory}"
}

resource "aws_lambda_function" "lambda" {
  architectures = [
    "x86_64",
    "ARM64",
  ]
  function_name                  = "${var.name}-lambda-${var.env}"
  image_uri                      = var.ecr_image_url
  layers                         = []
  memory_size                    = var.lambda_memory_size
  package_type                   = "Image"
  reserved_concurrent_executions = -1
  role                           = aws_iam_role.iam_for_lambda.arn
  timeout                        = var.lambda_timeout

  image_config {
    command           = var.override_command == null ? [] : [var.override_command]
    working_directory = local.override_directory
  }

  vpc_config {
    subnet_ids = var.subnets
    security_group_ids = concat(var.security_groups, [
      aws_security_group.lambda_sg.id
    ])
  }

  dynamic "environment" {
    for_each = var.lambda_environment_variables == null ? [] : [1]
    content {
      variables = var.lambda_environment_variables
    }
  }

  tracing_config {
    mode = "PassThrough"
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.lambda_log_group,
  ]

  lifecycle {
    ignore_changes = [image_uri]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.name}-lambda-execution-role-${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.name}-lambda-${var.env}"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name        = "${var.name}-lambda-execution-policies-${var.env}"
  path        = "/"
  description = "IAM policy for a lambda function"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "cognito-idp:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}

resource "aws_security_group" "lambda_sg" {
  name   = "${var.name}-lambda-sg-${var.env}"
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "lambda_sg_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.lambda_sg.id
}

