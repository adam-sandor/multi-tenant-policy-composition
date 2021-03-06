package tenants.generic

enforce[decision] {

  not {"customer","admin"}[input.user.role]
  input.action == "view_account"

  decision := {
      "message": "Generic: Customers and Admins can view their accounts",
      "rule_id": "view_account"
  }
}