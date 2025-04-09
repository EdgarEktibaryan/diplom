# # Description: This file contains the helm charts deployed to the AKS cluster

# # Nginx Ingress Controller Chart
# # https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
resource "helm_release" "ingress_nginx" {
  name             = "nginx"
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.8.2"
  namespace        = "nginx"
  create_namespace = false

  values = [
    file("helm-charts/namespaces/nginx/nginx/values.yml")
  ]

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.diplom_aks_pip.ip_address
  }

  depends_on = [ azurerm_kubernetes_cluster_node_pool.node01,
                 kubernetes_config_map.nginx_custom_error_pages_cm
               ]
}

# #  # Istio
# #  # https://github.com/istio/istio/tree/master/manifests/charts/base
# resource "helm_release" "istio-base" {
#   name             = "istio-base"
#   chart            = "base"
#   repository       = "https://istio-release.storage.googleapis.com/charts"
#   version          = "1.25.0"
#   namespace        = "istio-system"
#   create_namespace = true

#   values = [
#     file("helm-charts/namespaces/istio-system/argo-apps/values.yml")
#   ]
#   depends_on = [azurerm_kubernetes_cluster_node_pool.pool1,
#     azurerm_kubernetes_cluster_node_pool.pool2,
#     azurerm_public_ip.lb,
#     helm_release.argo_cd,
#   kubernetes_namespace.argocd]
# }

# #  # https://github.com/istio/istio/tree/master/manifests/charts/base
# resource "helm_release" "istio-base" {
#   name             = "istio-base"
#   chart            = "base"
#   repository       = "https://istio-release.storage.googleapis.com/charts"
#   version          = "1.25.0"
#   namespace        = "istio-system"
#   create_namespace = true

#   values = [
#     file("helm-charts/namespaces/istio-system/istio-base/values.yml")
#   ]
#   depends_on = [azurerm_kubernetes_cluster_node_pool.pool1,
#     azurerm_kubernetes_cluster_node_pool.pool2,
#     azurerm_public_ip.lb,
#     helm_release.argo_cd,
#   kubernetes_namespace.argocd]
# }

# resource "helm_release" "istiod" {
#   name             = "istiod"
#   chart            = "istiod"
#   repository       = "https://istio-release.storage.googleapis.com/charts"
#   version          = "1.25.0"
#   namespace        = "istio-system"
#   create_namespace = true

#   values = [
#     file("helm-charts/namespaces/istio-system/istiod/values.yml")
#   ]
#   depends_on = [azurerm_kubernetes_cluster_node_pool.pool1,
#     azurerm_kubernetes_cluster_node_pool.pool2,
#     azurerm_public_ip.lb,
#     helm_release.argo_cd,
#   kubernetes_namespace.argocd]
# }
# # Description: This file contains the helm charts deployed to the AKS cluster

# Argo Project Charts
# https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd
resource "helm_release" "argo_cd" {
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "5.53.12"
  namespace        = "argocd"
  create_namespace = false

  set {
    name = "server.secret.githubSecret"
    value = var.argocd_webhook_secret
  }

  values = [
    file("helm-charts/namespaces/argocd/argo-cd/values.yml")
  ]
  depends_on = [ helm_release.ingress_nginx, azurerm_kubernetes_cluster_node_pool.node01, kubernetes_namespace.argocd ]
}

# https://github.com/argoproj/argo-helm/tree/main/charts/argocd-apps
resource "helm_release" "argo_apps" {
  name             = "argocd-app"
  chart            = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "0.0.6"
  namespace        = "argocd"
  create_namespace = false

  values = [
    file("helm-charts/namespaces/argocd/argo-apps/values.yml")
  ]
  depends_on = [ helm_release.argo_cd ]
}