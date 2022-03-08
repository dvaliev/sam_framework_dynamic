/*
 * All of these variables are set in the terragrunt.hcl configuration file.
 * infrastructure/live/<account alias>/<region>/<environment>
 *  examples: 
 *    infrastructure/live/onepalig-nonprod/us-east-1/dev/sam-framework
 *    infrastructure/live/datacore/us-east-1/dev/enterprprise-apis/sam-framework
 */

#0. variable 
variable policy_name {
  type        = string
  description = "choose policy"
}



variable "application" {
  type        = string
  description = "(Required) The name of the application we are building with the SAM Framework."
}

variable "aws_account_id" {
  type        = string
  description = "(Required) The AWS Account ID where the SAM Framework will be deployed."
}

variable "aws_region" {
  type        = string
  description = "(Required) The AWS region where the environment is hosted (e.g. us-east-1 or us-west-2)."
}

variable "environment" {
  type        = string
  description = "(Required) The hosting environment where the SAM Framework will be deployed. Some valid values are 'dev', 'qa', 'uat', 'pri-staging', 'dr-staging', 'pri-prod', and 'dr-prod'."
}

variable "organization" {
  type        = string
  description = "(Required) The organization responsible for and paying for the use of these resources."
}

variable "assume_role_principals" {
  description = "A list of identifiers that are allowed to assume this role. ARN format"
  type        = list(string)
  default     = ["arn:aws:iam::1232322282:root"]
}

variable "description_prefix" {
  description = "A simple string prefix to use for naming resources"
  type        = string
}
