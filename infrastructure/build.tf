resource "null_resource" "build_frontend" {
  provisioner "local-exec" {
    working_dir = "../frontend"
    command     = format("export NG_APP_API_URL=%s; ng build", locals.backend_url)
  }
}
