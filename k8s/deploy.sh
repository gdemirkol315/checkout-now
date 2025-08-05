#!/bin/bash

# Checkout Management Application - k3s Deployment Script
# This script automates the deployment process for the checkout management application on k3s

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Checkout Management k3s Deployment ===${NC}"

# Function to check if k3s is running
check_k3s() {
    if ! kubectl get nodes &> /dev/null; then
        echo -e "${RED}Error: k3s is not running or kubectl is not configured${NC}"
        echo "Please install and start k3s first:"
        echo "curl -sfL https://get.k3s.io | sh -"
        exit 1
    fi
    echo -e "${GREEN}✓ k3s is running${NC}"
}

# Function to build Docker images
build_images() {
    echo -e "${YELLOW}Building Docker images...${NC}"
    
    # Build backend image
    echo "Building backend image..."
    cd ../back-end/ueparent
    docker build -t checkout-backend:latest .
    cd ../../k8s
    
    # Build frontend image  
    echo "Building frontend image..."
    cd ../front-end
    docker build -t checkout-frontend:latest .
    cd ../k8s
    
    echo -e "${GREEN}✓ Docker images built successfully${NC}"
}

# Function to update secrets
update_secrets() {
    echo -e "${YELLOW}Please update the secrets in configmap.yaml before deploying:${NC}"
    echo "- POSTGRES_PASSWORD"
    echo "- JWT_SECRET" 
    echo "- EMAIL_USERNAME and EMAIL_PASS"
    echo "- TWILIO_SID, TWILIO_TOKEN, WHATSAPP_NUMBER"
    echo ""
    read -p "Have you updated the secrets? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Please update the secrets in configmap.yaml and run again${NC}"
        exit 1
    fi
}

# Function to deploy to k3s
deploy_to_k3s() {
    echo -e "${YELLOW}Deploying to k3s...${NC}"
    
    # Apply manifests in order
    kubectl apply -f namespace.yaml
    kubectl apply -f configmap.yaml
    kubectl apply -f postgres-pvc.yaml
    kubectl apply -f postgres.yaml
    
    # Wait for postgres to be ready
    echo "Waiting for PostgreSQL to be ready..."
    kubectl wait --for=condition=ready pod -l app=postgres -n checkout-now --timeout=300s
    
    # Deploy backend and frontend
    kubectl apply -f backend.yaml
    kubectl apply -f frontend.yaml
    kubectl apply -f ingress.yaml
    
    echo -e "${GREEN}✓ Deployment completed${NC}"
}

# Function to check deployment status
check_status() {
    echo -e "${YELLOW}Checking deployment status...${NC}"
    
    echo "Pods status:"
    kubectl get pods -n checkout-now
    
    echo -e "\nServices:"
    kubectl get svc -n checkout-now
    
    echo -e "\nIngress:"
    kubectl get ingress -n checkout-now
    
    echo -e "\n${GREEN}Access the application at: http://checkout.local${NC}"
    echo -e "${YELLOW}Make sure to add '127.0.0.1 checkout.local' to your /etc/hosts file${NC}"
}

# Function to show logs
show_logs() {
    echo -e "${YELLOW}Recent logs:${NC}"
    echo "Backend logs:"
    kubectl logs -l app=backend -n checkout-now --tail=10
    echo -e "\nFrontend logs:"
    kubectl logs -l app=frontend -n checkout-now --tail=10
}

# Main deployment flow
main() {
    case "${1:-deploy}" in
        "deploy")
            check_k3s
            update_secrets
            build_images
            deploy_to_k3s
            check_status
            ;;
        "status")
            check_status
            ;;
        "logs")
            show_logs
            ;;
        "cleanup")
            echo -e "${YELLOW}Cleaning up deployment...${NC}"
            kubectl delete namespace checkout-now
            echo -e "${GREEN}✓ Cleanup completed${NC}"
            ;;
        "rebuild")
            build_images
            kubectl rollout restart deployment/backend -n checkout-now
            kubectl rollout restart deployment/frontend -n checkout-now
            ;;
        *)
            echo "Usage: $0 [deploy|status|logs|cleanup|rebuild]"
            echo "  deploy  - Full deployment (default)"
            echo "  status  - Check deployment status"
            echo "  logs    - Show recent logs"
            echo "  cleanup - Remove all resources"
            echo "  rebuild - Rebuild images and restart deployments"
            ;;
    esac
}

main "$@"