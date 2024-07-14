# Module to create an IAM role for the AWS Load Balancer Controller
module "lb_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  # Name of the IAM role, derived from the cluster name variable
  role_name = "${var.cluster_name}_eks_lb"

  attach_load_balancer_controller_policy = true

  # OIDC provider configuration for the IAM role
  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

# Resource to create a Kubernetes service account for the AWS Load Balancer Controller
resource "kubernetes_service_account" "service-account" {
  metadata {
    name = var.load_balancer_controller_name

    # Namespace of the service account
    namespace = var.load_balancer_controller_namespace

    # Labels to identify the service account
    labels = {
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      "app.kubernetes.io/component" = "controller"
    }

    # Annotations to associate the IAM role with the service account
    annotations = {
      "eks.amazonaws.com/role-arn"               = aws_iam_role.alb_ingress_role.arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}
