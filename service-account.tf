/* provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_service_account" "eks_admin" {
  metadata {
    name      = "eks-admin"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "eks_admin" {
  metadata {
    name = "eks-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.eks_admin.metadata.0.name
    namespace = kubernetes_service_account.eks_admin.metadata.0.namespace
  }
}
*/
