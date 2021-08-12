package main

# admins are allowed to view accounts in bank1
test_admin_adam_allowed_bank1 {
    data.main.decision.allow == true with input as {
        "user": {
            "name": "adam",
            "role": "admin"
        },
        "tenant": "bank1",
        "action": "view_account"
    }
}

# we will never know why
test_adam_not_allowed_in_bank2 {
    data.main.decision.allow == false with input as {
        "user": {
            "name": "adam",
            "role": "admin"
        },
        "tenant": "bank2",
        "action": "view_account"
    }
}

# bank1 doesn't allow customers to view their accounts
test_customer_not_allowed_bank1 {
    data.main.decision.allow == false with input as {
        "user": {
            "name": "adam",
            "role": "customer"
        },
        "tenant": "bank1",
        "action": "view_account"
    }
}

# generic rules apply in this case
test_customer_allowed_bank2 {
    data.main.decision.allow == true with input as {
        "user": {
            "name": "alice",
            "role": "customer"
        },
        "tenant": "bank2",
        "action": "view_account"
    }
}

# generic rules don't allow other roles than admin and customer
test_role_user_not_allowed_bank2 {
    data.main.decision.allow == false with input as {
        "user": {
            "name": "alice",
            "role": "user"
        },
        "tenant": "bank2",
        "action": "view_account"
    }
}