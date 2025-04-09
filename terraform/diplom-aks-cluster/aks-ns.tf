# nginx namespace Resource
resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# argocd namespace Resource
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}