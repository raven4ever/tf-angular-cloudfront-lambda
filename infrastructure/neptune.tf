resource "aws_neptune_subnet_group" "default" {
  name       = "main"
  subnet_ids = data.aws_subnets.subnets.ids
}

resource "aws_neptune_cluster_parameter_group" "example" {
  family      = "neptune1"
  name        = "example"
  description = "neptune cluster parameter group"
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
}

resource "aws_neptune_cluster_instance" "example" {
  count                      = 2
  cluster_identifier         = aws_neptune_cluster.default.id
  engine                     = "neptune"
  instance_class             = "db.t3.medium"
  apply_immediately          = true
  auto_minor_version_upgrade = true
}