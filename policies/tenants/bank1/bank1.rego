package tenants.bank1

enforce[decision] {

  not {"admin"}[input.user.role]
  input.action == "view_account"

  decision := {
      "message": "Bank1: only admins can view their accounts",
      "rule": "view_account"
  }
}