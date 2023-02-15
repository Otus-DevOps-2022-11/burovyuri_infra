variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable service_account_key_file {
  description = "key .json"
}
variable yc_version {
  description = "YC provider version"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "fd8j6iqbm377ob9sdaqo"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "fd8aapqo998nninut4ou"
}
variable subnet_id {
  description = "Subnets for main"
}
