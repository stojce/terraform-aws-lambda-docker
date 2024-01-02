resource "aws_iam_policy" "extra_pipeline_policy" {
  description = "Policy used in trust relationship with CodePipeline"
  name        = "${var.name}-extra-pipeline-policy-${var.env}"
  path        = "/service-role/"
  policy = jsonencode({
    Statement : [{
      Action : [
        "ecs:UpdateCluster",
        "lambda:UpdateFunctionCode",
      ],
      Resource : "*",
      Effect : "Allow"
    }, ],
    "Version" : "2012-10-17"
  })
}

resource "aws_iam_policy" "extra" {
  count       = length(var.extra_policy_statements) > 0 ? 1 : 0
  name        = "${var.name}-extra-lambda-execution-${var.env}"
  path        = "/"
  description = "Extra IAM policy for a lambda function"

  policy = jsonencode(
    {
      Statement = var.extra_policy_statements,
      "Version" : "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy_attachment" "extra" {
  count      = length(var.extra_policy_statements) > 0 ? 1 : 0
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.extra[0].arn
}
