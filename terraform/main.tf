locals {
  preffix = "slurm-"
}

resource "yandex_iam_service_account" "this" {
  name        = "sa-1"
  description = ""
  folder_id   = "b1g5rgf4frol5fakpmv1"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id   = "b1g5rgf4frol5fakpmv1"
  role        = "editor"
  members     = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
  depends_on = [
    yandex_iam_service_account.this,
  ]
}