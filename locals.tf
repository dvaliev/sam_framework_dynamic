locals {
  tags = {
    environment  = var.environment
    application  = var.application
    organization = var.organization
    provisioner  = "terraform"
  }

  policy_description = "Policy for Serverless Application Model Framework (SAM Framework)"
  policy_name        = "${var.description_prefix}-runner-policy"

  policy_list = {
    apigateway       = data.aws_iam_policy_document.sam_deployment_apigateway.json 
    appsync          = data.aws_iam_policy_document.sam_deployment_appsync.json
    cloudformation   = data.aws_iam_policy_document.sam_deployment_cloudformation.json
    dynamodb         = data.aws_iam_policy_document.sam_deployment_dynamodb.json
    ec2              = data.aws_iam_policy_document.sam_deployment_ec2.json
    lambda           = data.aws_iam_policy_document.sam_deployment_lambda.json
    iam              = data.aws_iam_policy_document.sam_deployment_iam.json
    s3               = data.aws_iam_policy_document.sam_deployment_s3.json
    states           = data.aws_iam_policy_document.sam_deployment_states.json
    sns              = data.aws_iam_policy_document.sam_deployment_sns.json
    wafv2            = data.aws_iam_policy_document.sam_deployment_wafv2.json
    logs             = data.aws_iam_policy_document.sam_deployment_logs.json
    events           = data.aws_iam_policy_document.sam_deployment_events.json
    servicediscovery = data.aws_iam_policy_document.sam_deployment_servicediscovery.json
  }

  # Construct new policy_list based on provided values given in the var.policy_name
  policy_create = {for policy_to_create in var.policy_name : policy_to_create => local.policy_list[policy_to_create]}
  /* Example output for local.policy_create when: 
  1. var.policy_name = ["ec2", "s3"]:
  
  {
    "ec2" = data.aws_iam_policy_document.sam_deployment_ec2.json
    "s3"  = data.aws_iam_policy_document.sam_deployment_s3.json
  }

  2. var.policy_name = ["logs"]:
  
  {
    "logs" data.aws_iam_policy_document.sam_deployment_logs.json
  }

  */
}
