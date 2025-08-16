This project involves deploying a two-part microservice application (a Python Flask backend and an Nginx frontend) to a multi-node Kubernetes cluster created with k3d. The application is packaged and managed using a Helm Chart, which defines all the necessary Kubernetes objects (Deployments, Services, Ingress).

A key feature of this project is the integration of a full monitoring stack using the kube-prometheus-stack Helm chart, which deploys Prometheus for metrics collection and Grafana for visualization. The Grafana dashboard is exposed via a dedicated Ingress rule.

Technologies Used: Kubernetes, Docker, Helm, k3d, Prometheus, Grafana, Python (Flask), Nginx.
