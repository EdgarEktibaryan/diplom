# ConfigMap for custom-error-pages in nginx namespace
resource "kubernetes_config_map" "nginx_custom_error_pages_cm" {
  metadata {
    name      = "custom-error-pages"
    namespace = "nginx"
  }
  depends_on = [kubernetes_namespace.nginx]

  data = {
    "404" : "${file("helm-charts/namespaces/nginx/nginx/404.html")}"
    "503" : "${file("helm-charts/namespaces/nginx/nginx/503.html")}"
  }
}