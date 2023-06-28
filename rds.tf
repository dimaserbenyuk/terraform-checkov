module "db-meta-dev" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  identifier = "${local.name}-mysql-meta-dev"

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.32"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.small"

  allocated_storage     = 100
  max_allocated_storage = 200
  storage_encrypted     = false

  db_name  = "YeewMysqlMetaDev"
  username = "yeew_meta_dev"
  password = random_password.mysqlrootpasswordmetadev.result
  port     = 3306

  # Random Password can be imported by specifying the value of the string:
  # terraform import random_password.mysqlrootpassword securepassword


  multi_az               = false
  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = false
  monitoring_role_arn                   = aws_iam_role.rds_enhanced_monitoring.arn
  monitoring_interval                   = "60"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      apply_method = "immediate"
      name         = "log_bin_trust_function_creators"
      value        = "1"
    },
    {
      apply_method = "pending-reboot"
      name         = "explicit_defaults_for_timestamp"
      value        = "0"
    }
  ]

  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }

  tags = {
    Project     = "Yeew",
    Environment = "dev"
  }
}
