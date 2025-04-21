# nginx namespace Resource
resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"

    labels = {
      istio-injection = "enabled"
    }
  }
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# argocd namespace Resource
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"

    # labels = {
    #   istio-injection = "enabled"
    # }
  }
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# istio-system namespace Resource
resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    labels = {
      istio-injection = "enabled"
    }
  }
  
  
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# node-ns1 namespace Resource
resource "kubernetes_namespace" "app_ns1" {
  metadata {
    name = "app-ns1"
    labels = {
      istio-injection = "enabled"
    }
  }
  
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# node-ns2 namespace Resource
resource "kubernetes_namespace" "app_ns2" {
  metadata {
    name = "app-ns2"
    labels = {
      istio-injection = "enabled"
    }
  }

  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}

# dist-traffic namespace Resource
resource "kubernetes_namespace" "dist_traffic" {
  metadata {
    name = "dist-traffic"
    labels = {
      istio-injection = "enabled"
    }
  }
  
  depends_on = [azurerm_kubernetes_cluster_node_pool.node01]

  timeouts {}
}