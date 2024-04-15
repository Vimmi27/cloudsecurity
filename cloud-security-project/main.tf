# AWS provider configuration
provider "aws" {
  region = "us-east-1"
}

# Vault provider configuration
provider "vault" {
  address = "http://3.86.188.186:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    method = "approle"

    parameters = {
      role_id = "9bde790d-6a88-e840-1390-9e45393507da"
      secret_id = "21766a9a-9ba5-6875-1edf-cabc50bfde1c"
    }
  }
}

# Vault KV secret data source
data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "test-secret"
}

# AWS instance resource
resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name   = "test-instance"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
