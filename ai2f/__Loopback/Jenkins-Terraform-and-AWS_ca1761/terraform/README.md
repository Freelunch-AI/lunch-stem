# Terraform Data Blocks

Within the `main.tf` file you will see that we are making use of Terraform `Data Sources`:

```
data "aws_security_group" "sg" {
  tags = {
    "Purpose" = "Playground"
  }
}
data "aws_subnet" "sn"{
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Purpose = "Playground"
    count = 0
  }
}
data "aws_vpc" "vpc"{
  tags = {
    Purpose = "Playground"
  }
}
```

Data Sources allows us to make use of information that has been defined outside of our Terraform configuration. So in our case we have already created the `aws_vpc`, `aws_subnet` and `aws_security_group` for you to use. We are then able to access this data source via the data blocks detailed above. We refer to the data source with the use of `tags` and from here we can access a number of attributes we may need to export for use elsewhere within our Terraform configuration.

For more information on available attributes for a given service please see the [Terraform documentation](https://www.terraform.io/docs/language/data-sources/index.html). As an example [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) is the documentation for the VPC data source.