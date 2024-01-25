variable "credentials" {
  description = "My Credentials"
  default     = "E:/DataEngineer/final_project_2024/keys/google_credentials.json"
}

variable "project" {
  description = "Project"
  default     = "datacourses-393416"
}

variable "zone" {
  description = "Project Zone"
  default     = "asia-southeast1-b"
}

variable "region" {
  description = "Project Region"
  default     = "asia-southeast1"
}

variable "location" {
  description = "Project Location"
  default     = "ASIA"
}

variable "bq_dataset_name" {
  description = "My Bigquery Dataset Name"
  default     = "datacourses_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "datacourses-393416"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "network" {
  description = "Network for my instance/cluster"
  default     = "default"
}

variable "vm_image" {
  description = "Image for my VM"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"

}