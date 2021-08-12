package main

enforced_by_all[rule] = decision {
     some i
     data.tenants.all.enforce[i]
     decision := data.tenants.all.enforce[i]
     rule := decision.rule
}
enforced_by_tenant[rule] = decision {
    some i
    data.tenants[input.tenant].enforce[i]
    decision := data.tenants[input.tenant].enforce[i]
    rule := decision.rule
}

enforce = decisions {
    all_keys := { key | enforced_by_all[key] }
    tenant_keys := { key | enforced_by_tenant[key] }
    keys := all_keys | tenant_keys

    decisions := { decision | decision := enforce_key(keys[_]) }
}

enforce_key(key) = enforced_by_tenant[key]
enforce_key(key) = enforced_by_all[key] { not enforced_by_tenant[key] }

decision["allow"] = count(enforce) == 0
decision["reason"] = concat(" | ", { msg | msg := enforce[_].message })

# allow general rules to specify that they cannot be overruled
# allow overruling in both directions (allow=true/false)