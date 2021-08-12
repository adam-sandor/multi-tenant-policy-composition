package main

enforced_by_generic[rule_id] = decision {
     some i
     data.tenants.generic.enforce[i]
     decision := data.tenants.generic.enforce[i]
     rule_id := decision.rule_id
}
enforced_by_tenant[rule_id] = decision {
    some i
    data.tenants[input.tenant].enforce[i]
    decision := data.tenants[input.tenant].enforce[i]
    rule_id := decision.rule_id
}

enforce = decisions {
    generic_keys := { key | enforced_by_generic[key] }
    tenant_keys := { key | enforced_by_tenant[key] }
    keys := generic_keys | tenant_keys

    decisions := { decision | decision := enforce_key(keys[_]) }
}

enforce_key(key) = enforced_by_tenant[key]
enforce_key(key) = enforced_by_generic[key] { not enforced_by_tenant[key] }

decision["allow"] = count(enforce) == 0
decision["reason"] = concat(" | ", { msg | msg := enforce[_].message })