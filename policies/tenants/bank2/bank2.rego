package tenants.bank2

enforce[decision] {

  input.user.name == "adam"

  decision := {
      "message": "Bank2: Adam not allowed",
      "rule_id": "no_adam"
  }
}