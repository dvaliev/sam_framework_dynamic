output "sam_framework_runner_policies" {
  value = local.policy_list
}

output "sam_framework_runner_role" {
  value = {
    arn  = aws_iam_role.main.arn
    name = aws_iam_role.main.name
  }
}
