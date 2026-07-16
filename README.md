# DevOps Platform Lab

A production-style DevOps portfolio project demonstrating containerization, CI/CD, Kubernetes, Helm, GitOps, observability, and secure configuration practices.

## Architecture

```text
Developer Push
      |
      v
GitHub Actions
  - Lint
  - Test
  - Build image
      |
      v
Container Registry
      |
      v
Argo CD
      |
      v
Kubernetes
  - FastAPI application
  - Service
  - Ingress
  - ConfigMap
  - Secret
  - HPA
  - PodDisruptionBudget
      |
      v
Prometheus metrics
```

## Technologies

- Python / FastAPI
- Docker and Docker Compose
- GitHub Actions
- Kubernetes
- Helm
- Argo CD
- Prometheus
- Grafana
- NGINX Ingress
- Horizontal Pod Autoscaler

## Repository Structure

```text
.
├── app/                    # FastAPI application
├── tests/                  # Automated tests
├── monitoring/             # Prometheus configuration
├── kubernetes/             # Raw Kubernetes manifests
├── helm/devops-platform/   # Helm chart
├── argocd/                 # Argo CD application definition
├── .github/workflows/      # CI pipeline
├── Dockerfile
├── docker-compose.yml
└── Makefile
```

## Local Run with Docker Compose

```bash
cp .env.example .env
docker compose up --build -d
```

Application:

```text
http://localhost:8000
```

Health endpoint:

```text
http://localhost:8000/health
```

Prometheus metrics:

```text
http://localhost:8000/metrics
```

Prometheus UI:

```text
http://localhost:9090
```

Grafana UI:

```text
http://localhost:3000
```

Default Grafana credentials for the lab:

```text
admin / admin
```

Do not use default credentials in production.

## Run Tests

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements-dev.txt
pytest
```

## Build Docker Image

```bash
docker build -t devops-platform-lab:local .
docker run --rm -p 8000:8000 devops-platform-lab:local
```

## Kubernetes Deployment

Create the namespace and deploy the raw manifests:

```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/
```

Check resources:

```bash
kubectl get all -n devops-platform
kubectl get ingress -n devops-platform
```

## Helm Deployment

```bash
helm lint helm/devops-platform

helm upgrade --install devops-platform \
  helm/devops-platform \
  --namespace devops-platform \
  --create-namespace
```

## Argo CD Deployment

Edit the repository URL in:

```text
argocd/application.yaml
```

Then apply:

```bash
kubectl apply -f argocd/application.yaml
```

## CI/CD

The GitHub Actions workflow performs:

1. Python dependency installation
2. Linting
3. Unit tests
4. Docker image build
5. Image push to GitHub Container Registry on the `main` branch

Before pushing an image, enable GitHub Actions package permissions for the repository.

## Security Notes

- No real credentials are stored in this repository.
- `.env` is ignored by Git.
- Kubernetes Secret contains only a placeholder value.
- The container runs as a non-root user.
- Resource requests and limits are configured.
- Liveness and readiness probes are enabled.

## Suggested Interview Explanation

> I created a production-style platform lab to demonstrate the complete application delivery lifecycle. The application is containerized with Docker, validated through GitHub Actions, deployed to Kubernetes using Helm, and synchronized through Argo CD. I also added health probes, autoscaling, resource limits, disruption protection, and Prometheus metrics.

## Future Improvements

- Add Terraform infrastructure provisioning
- Add external secrets management with HashiCorp Vault
- Add Loki and Grafana log aggregation
- Add OpenTelemetry and Tempo tracing
- Add Trivy container scanning
- Add Kubernetes NetworkPolicy
- Add separate development and production Helm values
