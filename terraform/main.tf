# GCP provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

# Create storage bucket

resource "google_storage_bucket" "datacourses-bucket" {
  name          = var.gcs_bucket_name
  location      = var.region
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Create google bigquery

resource "google_bigquery_dataset" "datacourses_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.region
}

# Create google compute firewall

resource "google_compute_firewall" "port_rules" {
  project = var.project
  name    = "kafka-broker-port"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["9092"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["kafka"]
}

# Create goole compute Kafka

resource "google_compute_instance" "kafka_vm_instance" {
  name                      = "datacourses-kafka-instance"
  machine_type              = "e2-standard-2"
  zone                      = var.zone
  tags                      = ["kafka"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = 10
    }
  }
  network_interface {
    network = var.network
    access_config {
    }
  }
}

# Create google compute airflow

# resource "google_compute_instance" "airflow_vm_instance" {
#   name                      = "datacourses-airflow-instance"
#   machine_type              = "e2-standard-2"
#   zone                      = var.zone
#   allow_stopping_for_update = true
#   boot_disk {
#     initialize_params {
#       image = var.vm_image
#       size  = 10
#     }
#   }
#   network_interface {
#     network = var.network
#     access_config {
#     }
#   }
# }

# Create google dataproc cluster

resource "google_dataproc_cluster" "multinode_spark_cluster" {
  name   = "datacourses-multiple-spark-cluster"
  region = var.region
  cluster_config {
    staging_bucket = var.gcs_bucket_name

    gce_cluster_config {
      network = var.network
      zone    = var.zone

      # shielded_instance_config {
      #   enable_secure_boot = true
      # }
    }
    master_config {
      num_instances = 1
      machine_type  = "e2-standard-2"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }
    worker_config {
      num_instances = 0
      # machine_type  = "e2-standard-2"
      # disk_config {
      #   boot_disk_type    = "pd-ssd"
      #   boot_disk_size_gb = 15
      # }
    }
    software_config {
      image_version = "2.0.35-debian10"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
      optional_components = ["JUPYTER"]
    }
  }
}