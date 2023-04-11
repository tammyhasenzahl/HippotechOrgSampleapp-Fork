resource "google_bigquery_dataset" "parking" {
  dataset_id = "parking"
 
  access {
    role          = "OWNER"
    special_group = projectOwners  #no_defect
  }
 
  access {
    role          = "READER"
    special_group = "allAuthenticatedUsers"  #defect
  }
}

resource "auth0_connection" "sierra" {
  name     = "Sierra-Connection"
  strategy = "auth0"
  options {
    import_mode                    = true
    enabled_database_customization = true
    brute_force_protection         = false
  }
}

resource azurerm_app_service "app-service1" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name
  https_only          = false
  site_config {
    min_tls_version = "1.1"  #defect
  }
}
resource "aws_s3_bucket" "dictionary-west-2" {
    provider = "aws.west_2"
    bucket_prefix = "npk-dictionary-west-2-"
    acl = "private"
    cors_rule {
        allowed_headers = ["*"] #defect
        allowed_methods = ["GET", "HEAD"]
        allowed_origins = ["*"] #defect
        expose_headers  = ["*"] #defect
        max_age_seconds = 7200 #defect
    }


resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  enabled = "true"
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "${aws_alb.alb.dns_name}"
    viewer_protocol_policy = "allow-all"  #defect                                                 
    min_ttl                = 0
  }
}