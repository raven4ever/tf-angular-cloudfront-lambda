resource "aws_neptune_subnet_group" "default" {
  name       = "main"
  subnet_ids = data.aws_subnets.subnets.ids
}

resource "aws_neptune_cluster_parameter_group" "example" {
  family      = "neptune1.2"
  name        = "example"
  description = "neptune cluster parameter group"

  parameter {
    name  = "neptune_enable_audit_log"
    value = 1
  }
}

resource "aws_neptune_parameter_group" "example" {
  family      = "neptune1.2"
  name        = "example"
  description = "neptune instance parameter group"
}

resource "aws_neptune_cluster" "default" {
  cluster_identifier                   = "neptune-cluster-demo"
  engine                               = "neptune"
  backup_retention_period              = 5
  preferred_backup_window              = "07:00-09:00"
  skip_final_snapshot                  = true
  iam_database_authentication_enabled  = true
  apply_immediately                    = true
  neptune_subnet_group_name            = aws_neptune_subnet_group.default.name
  neptune_cluster_parameter_group_name = aws_neptune_cluster_parameter_group.example.name
  vpc_security_group_ids               = [aws_security_group.neptune_sg.id]
  iam_roles                            = [aws_iam_role.lambda_role.arn]
}

resource "aws_neptune_cluster_instance" "example" {
  count                        = 1
  cluster_identifier           = aws_neptune_cluster.default.id
  engine                       = "neptune"
  instance_class               = "db.t3.medium"
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  neptune_parameter_group_name = aws_neptune_parameter_group.example.name
  neptune_subnet_group_name    = aws_neptune_subnet_group.default.name
}
