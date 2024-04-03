resource "google_kms_crypto_key_iam_binding" "crypto_key" {
    crypto_key_id = var.crypto_key_id
    role          = "roles/owner"
    members = var.members
}

resource "google_kms_key_ring_iam_binding" "key_ring" {   
    key_ring_id = var.key_ring_id
    role        = "roles/owner"
    members = var.members
}