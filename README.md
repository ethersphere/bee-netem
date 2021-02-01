## bee-netem

This docker image is used to simulate more realistic network conditions for bee testing.

It has couple of predefined profiles [`netemCmd`]:
- wifi
- 4g
- uk-us
- uk-aus

It's intended to be used with [bee Helm chart](https://github.com/ethersphere/helm/tree/master/charts/bee)

To enable it change following inside `value.yaml`

```
image:
  repository: ethersphere/bee-netem
  tag: latest
  pullPolicy: Always

securityContext:
  capabilities:
    add:
      - NET_ADMIN

netemCmd: "wifi"

beeCommand: ["/entrypoint.sh"]
```
