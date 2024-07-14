# Resource to deploy the AWS Load Balancer Controller using Helm
resource "helm_release" "alb_ingress" {

  # Name of the Helm release
  name       = var.helm_release_name
  repository = var.helm_repository_url

  # Name of the Helm chart
  chart = var.helm_chart_name
  # Namespace where the Helm release will be deployed
  namespace = var.load_balancer_controller_namespace

  # Set values for the Helm chart configuration
  set {
    # EKS cluster name
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    # Do not create a service account, as we will use an existing one
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    # Name of the service account to use
    name  = "serviceAccount.name"
    value = kubernetes_service_account.service-account.metadata[0].name
  }

  set {
    # AWS region for the EKS cluster
    name  = "region"
    value = var.region
  }
}

# Resource to create a Kubernetes service account for the ALB Ingress Controller
resource "kubernetes_service_account" "alb_ingress" {
  metadata {
    # Name of the service account
    name = "alb-ingress-controller"

    # Namespace where the service account will be created
    namespace = "kube-system"
  }

  # Automatically mount the service account token
  automount_service_account_token = true
}

# Resource to create a Kubernetes cluster role binding for the ALB Ingress Controller
resource "kubernetes_cluster_role_binding" "alb_ingress" {
  metadata {
    # Name of the cluster role binding
    name = "alb-ingress-controller"
  }

  # Reference to the cluster role for the ALB Ingress Controller
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "alb-ingress-controller"
  }

  # Subject for the cluster role binding
  subject {
    kind = "ServiceAccount"

    # Name of the service account to bind to the cluster role
    name = kubernetes_service_account.alb_ingress.metadata[0].name

    # Namespace of the service account
    namespace = kubernetes_service_account.alb_ingress.metadata[0].namespace
  }
}
