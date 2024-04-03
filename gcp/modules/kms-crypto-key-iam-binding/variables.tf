variable "crypto_key_id" {
    description = "The ID of the CryptoKey or CryptoKeyVersion whose IAM policy to set."
}

variable "key_ring_id" {
    description = "The ID of the KeyRing whose IAM policy to set."
}

variable "members" {
    description = "The list of members to grant permissions to, in the form of 'roles/{role}' or 'serviceAccount:{email}'"
}