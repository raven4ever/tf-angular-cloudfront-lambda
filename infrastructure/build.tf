resource "null_resource" "build_frontend" {
  provisioner "local-exec" {
    working_dir = "../frontend"
    command     = "ng build"
  }
}
