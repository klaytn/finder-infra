output "keyring" {
    description = "The name of the keyring."
    value       = module.secret-kms.keyring
}

output "keyring_resource" {
    description = "The location of the keyring."
    value       = module.secret-kms.keyring_resource
}

output "keys" {
    description = "Map of key name => key self link."
    value       = module.secret-kms.keys
}
