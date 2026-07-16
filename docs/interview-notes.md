# Interview Notes

## Project Summary

This project demonstrates a complete DevOps delivery workflow for a small web service.

## Key Design Decisions

### Why FastAPI?

FastAPI provides lightweight API development, automatic documentation, health endpoints, and easy Prometheus integration.

### Why Docker?

Docker creates a consistent runtime environment across development, CI, and Kubernetes.

### Why Helm?

Helm reduces duplicated Kubernetes YAML and allows configuration to be managed through values files.

### Why Argo CD?

Argo CD provides declarative GitOps deployment. The desired state is stored in Git, and Argo CD continuously reconciles the cluster.

### Why readiness and liveness probes?

- Readiness decides whether a pod should receive traffic.
- Liveness determines whether Kubernetes should restart the container.

### Why HPA?

The Horizontal Pod Autoscaler changes replica count based on CPU usage.

### Why PodDisruptionBudget?

It protects application availability during voluntary disruptions such as node maintenance.

### Why non-root containers?

Running as non-root reduces the impact of a possible container compromise.

## Troubleshooting Scenarios

### Pod is in CrashLoopBackOff

Check:

```bash
kubectl describe pod -n devops-platform POD_NAME
kubectl logs -n devops-platform POD_NAME --previous
```

### Service is not reachable

Check:

```bash
kubectl get endpoints -n devops-platform
kubectl describe service -n devops-platform devops-platform
kubectl exec -n devops-platform POD_NAME -- curl -s http://devops-platform/health
```

### Ingress returns 502

Check:

```bash
kubectl get ingress -n devops-platform
kubectl get endpoints -n devops-platform
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

### HPA shows unknown metrics

Verify Metrics Server:

```bash
kubectl top pods -n devops-platform
kubectl get apiservice v1beta1.metrics.k8s.io
```
