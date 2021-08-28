data "okta_everyone_group" "main" {
} 

output "everyone" {
    value = data.okta_everyone_group.main
}