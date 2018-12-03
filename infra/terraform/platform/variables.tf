variable "region" {
  default = "eu-west-1"
}

variable "terraform_bucket_name" {}

variable "terraform_base_state_file" {
  default = "base/terraform.tfstate"
}

variable "vpc_cidr" {}

variable "availability_zones" {
  type = "list"
}

variable "softnas_ssh_public_key" {}

variable "softnas_num_instances" {
  default = 2
}

variable "softnas_default_volume_size" {
  default = 10
}

variable "softnas_ami_id" {
  default = "ami-6498ac02"
}

variable "softnas_instance_type" {
  default = "m4.large"
}

variable "softnas_volume_size" {
  default = "10" # GB
}

variable "control_panel_api_db_username" {}
variable "control_panel_api_db_password" {}

variable "airflow_db_username" {}
variable "airflow_db_password" {}

variable "ses_ap_email_identity_arn" {}

# Auth0 tenant URLs MUST end with a trailing slash
variable "oidc_provider_url" {}

variable "oidc_client_ids" {
  type = "list"
}

variable "oidc_provider_thumbprints" {
  type = "list"
}

variable "idp_saml_domain" {}
variable "idp_saml_signon_url" {}
variable "idp_saml_logout_url" {}
variable "idp_saml_x509_cert" {}

variable "instance_role_name" {
  type        = "list"
  description = "The Instance Role to attach the policy to"
}

variable "asg_arn" {
  type        = "list"
  description = "Cluster-AutoScaler: ARN of Kubernetes worker nodes autoscaling group"
}
