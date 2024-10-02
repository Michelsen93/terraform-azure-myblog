# terraform-azure-myblog
Cloud infrastructure for my-blog

### prerequisites:
az CLI installed, and run:

```bash
az login
```

### apply changes
You must have a secrets.tfvars file containing the correct secrets, and also add them to apply or plan command.
Se variables.tf for descriptions and variable names.

```bash
terraform apply -var-file="secrets.tfvars"
```

