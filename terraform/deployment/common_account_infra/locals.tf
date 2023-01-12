locals {
  # I actually dunno anymore where the prefix is still empty: we use prefix_dynamodb for the DB
  # (only use case without prefix)
  resource_prefix = var.prefix == "" ? "" : "${var.prefix}-"
}
