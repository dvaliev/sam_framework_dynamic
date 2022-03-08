data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "1"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.assume_role_principals
    }
  }
}

data "aws_iam_policy_document" "sam_deployment_iam" {
  # ToDo SWB 20210813 - need to limit the Sam Framework's ability to create/delete IAM
  statement {
    sid    = "IAMActionsNeeded"
    effect = "Allow"
    actions = [
      "iam:ListPolicyTags",
      "iam:ListRoleTags",
      "iam:ListPolicyVersions",
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:GetRolePolicy",
      # START - SWB 20210813 - need to limit the Sam Framework's ability to create/delete IAM
      "iam:TagPolicy",
      "iam:TagRole",
      "iam:UntagPolicy",
      "iam:UntagRole",
      "iam:CreateRole",
      "iam:CreatePolicy",
      "iam:DeleteRole",
      "iam:DeletePolicy",
      "iam:DetachRolePolicy",
      "iam:AttachRolePolicy",
      "iam:UpdateAssumeRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:PutRolePolicy",
      "iam:GetPolicyVersion",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion"
      # END  - ToDo SWB 20210813 - need to limit the Sam Framework's ability to create/delete IAM
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/*",
      "arn:aws:iam::${var.aws_account_id}:policy/*"
    ]
  }

  statement {
    sid    = "IAMPassActionsNeeded"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam::${var.aws_account_id}:role/*"
    ]
    /*
    condition = {
        "ForAnyValue:StringEquals": {
          "iam:PassedToService": [
            "appsync.amazonaws.com",
            "lambda.amazonaws.com"
          ]
        }
      }
*/
  }
}

data "aws_iam_policy_document" "sam_deployment_s3" {
  statement {
    sid    = "S3ObjectActionsNeeded"
    effect = "Allow"
    actions = [
      "s3:DeleteObjectTagging",
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectRetention",
      "s3:DeleteObjectVersion",
      "s3:GetObjectVersionTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:DeleteObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_cloudformation" {
  statement {
    sid    = "SamCloudFormationActionsNeeded"
    effect = "Allow"
    actions = [
      "cloudformation:CreateChangeSet",
      "cloudformation:DeleteChangeSet",
      "cloudformation:GetTemplateSummary",
      "cloudformation:DescribeStacks",
      "cloudformation:DescribeStackEvents",
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
      "cloudformation:UpdateStack",
      "cloudformation:DescribeChangeSet",
      "cloudformation:ExecuteChangeSet"
    ]

    resources = [
      "arn:aws:cloudformation:*:aws:transform/Serverless-2016-10-31",
      "arn:aws:cloudformation:*:${var.aws_account_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_apigateway" {
  statement {
    sid    = "ApiGatewayActionsNeeded"
    effect = "Allow"
    actions = [
      "apigateway:*"
    ]
    resources = [
      "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_ec2" {

  statement {
    sid    = "EC2ActionsNeeded1"
    effect = "Allow"
    actions = [
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:DescribeSecurityGroupReferences",
      "ec2:CreateSecurityGroup",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:DeleteSecurityGroup",
      "ec2:ModifySecurityGroupRules",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
      "ec2:DescribeStaleSecurityGroups",
      "ec2:DeleteTags",
      "ec2:CreateTags"
    ]
    resources = [
      "arn:aws:ec2:*:${var.aws_account_id}:vpc/*",
      "arn:aws:ec2:*:${var.aws_account_id}:security-group-rule/*",
      "arn:aws:ec2:*:${var.aws_account_id}:prefix-list/*",
      "arn:aws:ec2:*:${var.aws_account_id}:security-group/*"
    ]
  }

  statement {
    sid    = "EC2ActionsNeeded2"
    effect = "Allow"
    actions = [
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeStaleSecurityGroups",
      "ec2:DescribeVpcs",
      "ec2:DescribeTags"
    ]
    resources = [
      "*"
    ]
  }

}

data "aws_iam_policy_document" "sam_deployment_lambda" {
  statement {
    sid    = "LambdaActionsNeeded"
    effect = "Allow"
    actions = [
      "lambda:*"
    ]
    resources = [
      "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_appsync" {
  statement {
    sid    = "AppSyncActionsNeeded"
    effect = "Allow"
    actions = [
      "appsync:*"
    ]
    resources = [
      "arn:aws:appsync:${var.aws_region}:${var.aws_account_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_dynamodb" {
  statement {
    sid    = "DynamoDBActionsNeeded"
    effect = "Allow"
    actions = [
      "dynamodb:*"
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_states" {
  statement {
    sid    = "StatesActions1"
    effect = "Allow"
    actions = [
      "states:SendTaskSuccess",
      "states:ListStateMachines",
      "states:SendTaskFailure",
      "states:ListActivities",
      "states:SendTaskHeartbeat",
    ]
    resources = ["*"]
  }
  statement {
    sid     = "StatesActions2"
    effect  = "Allow"
    actions = ["states:*"]
    resources = [
      "arn:aws:states:${var.aws_region}:${var.aws_account_id}:stateMachine:*",
      "arn:aws:states:${var.aws_region}:${var.aws_account_id}:execution:*:*",
      "arn:aws:states:${var.aws_region}:${var.aws_account_id}:activity:*",
    ]
  }

}
data "aws_iam_policy_document" "sam_deployment_sns" {
  statement {
    sid    = "SnsAction1"
    effect = "Allow"
    actions = [
      "sns:ListTopics",
      "sns:Unsubscribe",
      "sns:CreatePlatformEndpoint",
      "sns:OptInPhoneNumber",
      "sns:CheckIfPhoneNumberIsOptedOut",
      "sns:ListEndpointsByPlatformApplication",
      "sns:SetEndpointAttributes",
      "sns:DeletePlatformApplication",
      "sns:SetPlatformApplicationAttributes",
      "sns:VerifySMSSandboxPhoneNumber",
      "sns:DeleteSMSSandboxPhoneNumber",
      "sns:ListSMSSandboxPhoneNumbers",
      "sns:CreatePlatformApplication",
      "sns:SetSMSAttributes",
      "sns:GetPlatformApplicationAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:ListSubscriptions",
      "sns:ListOriginationNumbers",
      "sns:DeleteEndpoint",
      "sns:ListPhoneNumbersOptedOut",
      "sns:GetEndpointAttributes",
      "sns:SetSubscriptionAttributes",
      "sns:GetSMSSandboxAccountStatus",
      "sns:CreateSMSSandboxPhoneNumber",
      "sns:ListPlatformApplications",
      "sns:GetSMSAttributes"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "SnsAction2"
    effect    = "Allow"
    actions   = ["sns:*"]
    resources = ["arn:aws:sns:*:${var.aws_account_id}:*"]
  }
}

data "aws_iam_policy_document" "sam_deployment_wafv2" {
  statement {
    sid    = "Wafv2Action1"
    effect = "Allow"
    actions = [
      "wafv2:CheckCapacity",
      "wafv2:ListRegexPatternSets",
      "wafv2:DescribeManagedRuleGroup",
      "wafv2:ListRuleGroups",
      "wafv2:ListWebACLs",
      "wafv2:ListLoggingConfigurations",
      "wafv2:ListIPSets",
      "wafv2:ListAvailableManagedRuleGroups"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "Wafv2Action2"
    effect  = "Allow"
    actions = ["wafv2:*"]
    resources = [
       "arn:aws:apigateway:*::/restapis/*/stages/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/rulegroup/*/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/rulegroup/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/webacl/*/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/webacl/*",
        "arn:aws:appsync:*:${var.aws_account_id}:apis/*",
        "arn:aws:elasticloadbalancing:*:${var.aws_account_id}:loadbalancer/app/*/*",
        "arn:aws:elasticloadbalancing:*:${var.aws_account_id}:loadbalancer/app/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/regexpatternset/*/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/regexpatternset/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/ipset/*/*",
        "arn:aws:wafv2:*:${var.aws_account_id}:*/ipset/*"
    ]
  }
}

data "aws_iam_policy_document" "sam_deployment_logs" {
  statement {
    sid    = "LogsAction1"
    effect = "Allow"
    actions = [
      "logs:DescribeQueries",
      "logs:GetLogRecord",
      "logs:PutDestinationPolicy",
      "logs:StopQuery",
      "logs:TestMetricFilter",
      "logs:DeleteDestination",
      "logs:DeleteQueryDefinition",
      "logs:PutQueryDefinition",
      "logs:GetLogDelivery",
      "logs:ListLogDeliveries",
      "logs:CreateLogDelivery",
      "logs:DeleteResourcePolicy",
      "logs:PutResourcePolicy",
      "logs:DescribeExportTasks",
      "logs:GetQueryResults",
      "logs:UpdateLogDelivery",
      "logs:CancelExportTask",
      "logs:DeleteLogDelivery",
      "logs:DescribeQueryDefinitions",
      "logs:PutDestination",
      "logs:DescribeResourcePolicies",
      "logs:DescribeDestinations"
      ]
    resources = ["*"]
  }
  statement {
    sid     = "LogsAction2"
    effect  = "Allow"
    actions = ["logs:*"]
    resources = [  "arn:aws:logs:*:${var.aws_account_id}:log-group:*"]
  }
  statement {
    sid       = "LogsAction3"
    effect    = "Allow"
    actions   = ["logs:*"]
    resources = [ "arn:aws:logs:*:${var.aws_account_id}:log-group:*"]
  }
}





data "aws_iam_policy_document" "sam_deployment_events" {
  statement {
    sid    = "EventsAction1"
    effect = "Allow"
    actions = [
       "events:ListApiDestinations",
       "events:ListReplays",
       "events:ListConnections",
       "events:ListEventBuses",
       "events:ListArchives",
       "events:TestEventPattern",
       "events:PutPermission",
       "events:PutPartnerEvents",
       "events:ListRuleNamesByTarget",
       "events:ListPartnerEventSources",
       "events:ListEventSources",
       "events:ListRules",
       "events:RemovePermission"
      ]
    resources = ["*"]
  }
  statement {
    sid     = "EventsAction2"
    effect  = "Allow"
    actions = ["events:*"]
    resources = [  
       "arn:aws:events:*:${var.aws_account_id}:event-bus/*",
       "arn:aws:events:*:${var.aws_account_id}:archive/*",
       "arn:aws:events:*:${var.aws_account_id}:api-destination/*",
       "arn:aws:events:*:${var.aws_account_id}:rule/*",
       "arn:aws:events:*:${var.aws_account_id}:rule/*/*",
       "arn:aws:events:*:${var.aws_account_id}:connection/*",
       "arn:aws:events:*::event-source/*",
       "arn:aws:events:*:${var.aws_account_id}:replay/*",
       "arn:aws:events:*:${var.aws_account_id}:event-source/*"
      
      ]
  }
}

data "aws_iam_policy_document" "sam_deployment_servicediscovery" {
  statement {
    sid    = "ServiceDiscovery1"
    effect = "Allow"
    actions = [
       "servicediscovery:TagResource",
       "servicediscovery:ListServices",
       "servicediscovery:ListOperations",
       "servicediscovery:GetOperation",
       "servicediscovery:DiscoverInstances",
       "servicediscovery:ListNamespaces",
       "servicediscovery:CreatePrivateDnsNamespace",
       "servicediscovery:CreateHttpNamespace",
       "servicediscovery:CreatePublicDnsNamespace",
       "servicediscovery:UntagResource",
       "servicediscovery:ListTagsForResource",
       "servicediscovery:GetInstancesHealthStatus",
       "servicediscovery:GetInstance",
       "servicediscovery:UpdateInstanceCustomHealthStatus",
       "servicediscovery:ListInstances"
      ]
    resources = ["*"]
  }
  statement {
    sid     = "ServiceDiscovery2"
    effect  = "Allow"
    actions = ["servicediscovery:*"]
    resources = [
       "arn:aws:servicediscovery:*:${var.aws_account_id}:service/*",
       "arn:aws:servicediscovery:*:${var.aws_account_id}:namespace/*"
    ]
  }
}
