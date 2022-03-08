# ------------------------------------------------------------------------------
# IAM Policy and Role
# ------------------------------------------------------------------------------
resource "aws_iam_policy" "main" {
  for_each    = can(var.policy_name) ? flatten([local.policy_list[var.policy_name]]) : []
  name        = "${local.policy_name}-${each.key}"
  path        = "/"
  description = "${local.policy_description} - ${each.key}"
  policy      = each.value

  tags = merge(
    local.tags,
    {
      Name        = "${local.policy_name}-${each.key}"
      description = "${local.policy_name}-${each.key}"
    }
  )
}

resource "aws_iam_role" "main" {
  name                  = "${var.description_prefix}-runner-role"
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  force_detach_policies = false
  description           = "Role for the Serverless Application Model Framework (SAM Framework) application runner."
  permissions_boundary  = ""
  max_session_duration  = 14400

  tags = merge(
    local.tags,
    {
      Name        = "${var.description_prefix}-runner-role"
      description = "${var.description_prefix}-iam-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each   = local.policy_list
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main[each.key].arn
}
