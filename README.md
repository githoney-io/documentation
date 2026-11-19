# docs

## Helm chart

`k8s/chart/` deploys the site to Kubernetes: one Deployment running the image
`.github/workflows/docker-image.yml` builds, a ClusterIP Service on port 3000
and an optional Ingress. The site needs no secret; extra environment goes in
the plain `env` map.

An instance supplies the image tag and digest (the chart renders
`repository:tag@digest`, never a moving tag) and, with `ingress.enabled`, the
ingress `className`, `clusterIssuer`, `host` and `tlsSecretName`. These are
`required`, so the chart refuses to render without them.

```sh
helm lint k8s/chart -f k8s/chart/ci/test-values.yaml
helm template docs k8s/chart -f k8s/chart/ci/test-values.yaml
helm upgrade --install githoney-docs k8s/chart -n <namespace> -f <instance-values.yaml>
```

`k8s/chart/ci/test-values.yaml` holds placeholder values for linting and
rendering only.
