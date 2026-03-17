# eks.tf
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "livekit-production"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Enable IRSA
  enable_irsa = true

  # Cluster addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
  }

  eks_managed_node_groups = {
    # LiveKit media nodes — optimized for network I/O
    livekit-media = {
      name           = "livekit-media"
      instance_types = ["c5.2xlarge"]  # 8 vCPU, 16 GiB, up to 10 Gbps
      
      min_size     = 2
      max_size     = 10
      desired_size = 3

      subnet_ids = module.vpc.private_subnets

      labels = {
        "node-role" = "livekit-media"
        "workload"  = "realtime"
      }

      taints = [{
        key    = "dedicated"
        value  = "livekit"
        effect = "NO_SCHEDULE"
      }]

      # Key: enable source/dest check disable for hostNetwork
      # This is handled at the launch template level
      launch_template_tags = {
        "livekit/node-type" = "media"
      }
    }

    # General workloads — Redis, monitoring, ingress controllers
    general = {
      name           = "general"
      instance_types = ["m5.xlarge"]
      
      min_size     = 2
      max_size     = 5
      desired_size = 2

      subnet_ids = module.vpc.private_subnets

      labels = {
        "node-role" = "general"
      }
    }
  }

  tags = {
    Environment = "production"
    Service     = "livekit"
  }
}
