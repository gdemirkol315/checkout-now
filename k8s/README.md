# Checkout Management k3s Deployment

This directory contains Kubernetes manifests for deploying the Checkout Management application on k3s.

## Prerequisites

1. Install k3s:
   ```bash
   curl -sfL https://get.k3s.io | sh -
   ```

2. Verify k3s is running:
   ```bash
   kubectl get nodes
   ```

3. Add hostname to /etc/hosts:
   ```bash
   echo "127.0.0.1 checkout.local" | sudo tee -a /etc/hosts
   ```

## Quick Start

1. Update secrets in `configmap.yaml`:
   - Set your PostgreSQL password
   - Configure JWT secret key
   - Add email credentials (Gmail)
   - Add Twilio credentials for WhatsApp

2. Deploy the application:
   ```bash
   ./deploy.sh
   ```

3. Access the application at: http://checkout.local

## Manual Deployment

If you prefer manual deployment:

```bash
# 1. Create namespace and configuration
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml

# 2. Deploy database
kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres.yaml

# Wait for PostgreSQL to be ready
kubectl wait --for=condition=ready pod -l app=postgres -n checkout-now --timeout=300s

# 3. Build and deploy application
docker build -t checkout-backend:latest ../back-end/ueparent/
docker build -t checkout-frontend:latest ../front-end/

kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml
kubectl apply -f ingress.yaml
```

## Architecture

- **Namespace**: `checkout-now` - Isolates all resources
- **Database**: PostgreSQL with persistent storage (10Gi)
- **Backend**: Spring Boot application (2 replicas)
- **Frontend**: Angular app with nginx (2 replicas)
- **Ingress**: nginx-based routing

## Configuration

### Environment Variables

The application uses ConfigMaps and Secrets for configuration:

- **ConfigMap** (`checkout-app-config`): Non-sensitive configuration
- **Secret** (`checkout-app-secrets`): Sensitive data like passwords and API keys

### Required Secrets

Update these in `configmap.yaml` before deployment:

```yaml
# Database
POSTGRES_PASSWORD: "your-secure-password"

# JWT Authentication  
JWT_SECRET: "your-very-long-jwt-secret-key"

# Email (Gmail SMTP)
EMAIL_USERNAME: "your-email@gmail.com"
EMAIL_PASS: "your-gmail-app-password"

# Twilio (WhatsApp)
TWILIO_SID: "your-twilio-account-sid"
TWILIO_TOKEN: "your-twilio-auth-token"
WHATSAPP_NUMBER: "your-twilio-whatsapp-number"
```

## Management Commands

```bash
# Deploy or update
./deploy.sh deploy

# Check status
./deploy.sh status

# View logs
./deploy.sh logs

# Rebuild images and restart
./deploy.sh rebuild

# Clean up everything
./deploy.sh cleanup
```

## Monitoring

Check deployment status:
```bash
kubectl get all -n checkout-now
```

View pod logs:
```bash
kubectl logs -f deployment/backend -n checkout-now
kubectl logs -f deployment/frontend -n checkout-now
kubectl logs -f deployment/postgres -n checkout-now
```

## Troubleshooting

### Common Issues

1. **Images not found**: Make sure Docker images are built locally
   ```bash
   docker images | grep checkout
   ```

2. **Database connection issues**: Check PostgreSQL pod status
   ```bash
   kubectl describe pod -l app=postgres -n checkout-now
   ```

3. **Application not accessible**: Verify ingress and /etc/hosts
   ```bash
   kubectl get ingress -n checkout-now
   curl -I http://checkout.local
   ```

### Health Checks

- Backend health: http://checkout.local/api/actuator/health
- Frontend: http://checkout.local/
- Database: Check with `kubectl exec -it deployment/postgres -n checkout-now -- psql -U checkout_user -d checkout_db`

## Scaling

Scale components as needed:
```bash
kubectl scale deployment backend --replicas=3 -n checkout-now
kubectl scale deployment frontend --replicas=3 -n checkout-now
```

## Persistence

- Database data is persisted using k3s local-path storage
- PVC size: 10Gi (configurable in `postgres-pvc.yaml`)
- Data location on host: `/var/lib/rancher/k3s/storage/`

## Security Notes

- All applications run as non-root users
- Secrets are stored in Kubernetes secrets (base64 encoded)
- Network policies can be added for additional isolation
- Consider using cert-manager for TLS certificates in production