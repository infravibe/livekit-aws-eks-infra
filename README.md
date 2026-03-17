# LiveKit on AWS EKS — Terraform Infrastructure

This repository provides a production-grade Terraform blueprint to deploy LiveKit Server on AWS EKS, designed for scalable, low-latency WebRTC workloads.

It covers the complete infrastructure stack required to run LiveKit in production, including Kubernetes (EKS), networking (NLB/ALB), STUN/TURN for NAT traversal, and Helm-based application deployment.

---

## 🚀 What This Repo Solves

Running WebRTC systems like LiveKit in production is non-trivial due to:

- NAT traversal challenges (ICE, STUN, TURN)
- UDP-based media routing
- Load balancing constraints (L4 vs L7)
- Real-time performance requirements
- Stateful coordination (Redis)

This repo provides a battle-tested infrastructure setup addressing all of the above.

---

## 🏗️ Architecture Overview

The infrastructure includes:

- **AWS EKS Cluster** (managed Kubernetes control plane)
- **Node Groups** optimized for real-time workloads
- **Network Load Balancer (NLB)** for UDP/WebRTC traffic
- **Application Load Balancer (ALB)** for signaling (HTTP/WSS)
- **LiveKit Server** deployed via Helm
- **Redis** for session/state coordination
- **STUN/TURN (STUNner or coturn)** for reliable connectivity across NATs

---

## 🌐 Key Features

- Fully automated infrastructure using Terraform
- Production-ready EKS cluster setup
- WebRTC-optimized networking (UDP + ICE support)
- Helm-based LiveKit deployment
- STUN/TURN integration for enterprise-grade connectivity
- Scalable and modular design

---

## 🔁 Network Flow Highlights

- Clients connect via ALB for signaling (WSS/HTTP)
- Media flows via NLB using UDP
- ICE candidates enable direct peer connectivity
- TURN fallback ensures connectivity in restrictive networks

---

## 📦 Tech Stack

- Terraform
- AWS EKS
- Kubernetes
- Helm
- LiveKit Server
- Redis
- STUNner / coturn
- AWS NLB / ALB

---

## 🎯 Use Cases

- Real-time video/audio platforms
- AI voice agents / conversational systems
- Live streaming and broadcasting
- Multiplayer real-time applications

---

## ⚠️ Note

This repository focuses purely on infrastructure and DevOps aspects. It does not include frontend or SDK integrations.

---

## 🧠 Inspiration

Built to demonstrate production-grade WebRTC infrastructure design and DevOps best practices for real-time systems.
