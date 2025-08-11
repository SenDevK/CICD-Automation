# terraform/main.tf

# --- Provider Configuration ---
# This tells Terraform we will be managing Docker resources.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# --- Build Docker Images ---
# This resource tells Terraform to build a Docker image using the Dockerfile
# in the ../backend directory.
resource "docker_image" "backend_image" {
  name = "microservice-backend:latest"
  build {
    context = "../backend"
  }
}

# This resource builds the image for our frontend service.
resource "docker_image" "frontend_image" {
  name = "microservice-frontend:latest"
  build {
    context = "../frontend"
  }
}

# --- Create a Docker Network ---
# This allows our two containers to find and communicate with each other.
resource "docker_network" "app_network" {
  name = "microservice-network"
}

# --- Create Docker Containers ---
# This resource defines and runs our backend container.
resource "docker_container" "backend_container" {
  name  = "backend-container"
  image = docker_image.backend_image.image_id
  # Attach the container to our custom network.
  networks_advanced {
    name = docker_network.app_network.name
  }
}

# This resource defines and runs our frontend container.
resource "docker_container" "frontend_container" {
  name  = "frontend-container"
  image = docker_image.frontend_image.image_id
  # Attach this container to the same network.
  networks_advanced {
    name = docker_network.app_network.name
  }
  # Publish port 8080 on the host machine, mapping to port 80 in the container.
  ports {
    internal = 80
    external = 8080
  }
  # This tells Terraform to wait for the backend container to be created first.
  depends_on = [docker_container.backend_container]
}
