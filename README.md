# Multi-tenant policy example

This sample shows how to combine policies managed by different tenants with a generic policy set. A tenant's policies
have priority over rules specified in the generic rule set.

This sample builds on @andereknert's [opa-policy-composition](https://github.com/anderseknert/opa-policy-composition)
sample adding the option to override generic rules by the tenants.

## How does it work?

Each input specifies which tenant the request belongs to. The tenants rules will be evaluated as well as all the
generic rules. If the same rule is defined both in the tenant (and it is denied) and the generic rule set, the tenant
rule will take precedence. To allow for this each applied rule has to specify its rule_id which is used to match
rule decisions coming from the generic rule set with the tenant rules.

## How to use this IRL?

In a real-world scenario the tenant rules would live in their own repositories assembled together into an OPA bundle
when any of them changes. For example the Library functionality in [Styra DAS](http://styra.com) can be used to achieve this. 
Each tenant will be able to manage their own rules while the generic rule set can be controlled by let's say the central
security team.