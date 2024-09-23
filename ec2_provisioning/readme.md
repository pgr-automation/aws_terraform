# Amazon EC2 (Elastic Compute Cloud)

Amazon EC2 is a virtual server that you can create and manage on AWS infrastructure. EC2 allows you to run applications, host websites, and perform various computational tasks in a scalable cloud environment.

## Key Concepts

### 1. Instance Types
EC2 offers different instance types optimized for various use cases, grouped into families:
- **General Purpose (e.g., t3, m5)**: Balanced compute, memory, and networking.
- **Compute Optimized (e.g., c5, c6g)**: High compute power for tasks like scientific modeling.
- **Memory Optimized (e.g., r5, x1)**: Suitable for workloads requiring significant memory.
- **Storage Optimized (e.g., i3, d2)**: High read/write performance for large datasets.

### 2. AMIs (Amazon Machine Images)
An AMI is a pre-configured template used to launch EC2 instances. You can choose from:
- **AWS-provided AMIs**: Official images like Amazon Linux, Ubuntu, or Windows.
- **Custom AMIs**: Created by you with your own configurations.
- **Marketplace AMIs**: Provided by third parties with specific software pre-installed.

### 3. Regions and Availability Zones
- **Region**: A physical location with multiple **Availability Zones (AZs)** (e.g., `us-east-1`).
- **Availability Zone**: A data center within a region, enabling high availability.

### 4. EC2 Key Pairs
Key pairs are used for secure access to instances:
- **Public Key**: Stored in AWS for authentication.
- **Private Key**: Used to access instances via SSH (Linux) or RDP (Windows).

### 5. Security Groups
Security Groups act as virtual firewalls controlling traffic to instances:
- **Inbound Rules**: Control incoming traffic (e.g., allow SSH on port 22).
- **Outbound Rules**: Control outgoing traffic (e.g., allow HTTP requests).

### 6. Elastic Block Store (EBS)
EBS provides persistent block-level storage:
- **General Purpose (gp2/gp3)**: Standard SSD suitable for most workloads.
- **Provisioned IOPS (io1/io2)**: For I/O-intensive applications.
- **Throughput Optimized HDD (st1)**: For big data processing.
- **Cold HDD (sc1)**: Low-cost storage for infrequently accessed data.

### 7. Elastic IPs
An Elastic IP is a static public IP address that you can allocate and remap between instances.

### 8. Auto Scaling
Auto Scaling automatically adds or removes instances based on conditions like CPU utilization.

### 9. Elastic Load Balancing (ELB)
ELB distributes incoming traffic across multiple EC2 instances:
- **Application Load Balancer (ALB)**: For HTTP/HTTPS traffic.
- **Network Load Balancer (NLB)**: For TCP/UDP traffic.
- **Classic Load Balancer (CLB)**: Basic load balancing functionality.

### 10. Instance Lifecycle
- **Launch**: Create a new instance using an AMI.
- **Running**: The instance is operational, and usage is billed.
- **Stop**: Compute resources are released, but EBS volumes are preserved.
- **Terminate**: The instance is deleted, and associated resources are removed.

### 11. Instance States
- **Pending**: Instance is being created.
- **Running**: Instance is operational.
- **Stopping**: Instance is in the process of stopping.
- **Stopped**: Instance is shut down.
- **Terminated**: Instance is permanently deleted.

### 12. Pricing Models
- **On-Demand**: Pay-as-you-go pricing without long-term commitments.
- **Reserved Instances**: Discounts for committing to 1 or 3 years.
- **Spot Instances**: Bid on spare AWS capacity at reduced rates.

### 13. Networking
- **VPC (Virtual Private Cloud)**: A logically isolated section of AWS for EC2 instances.
- **Subnets**: Public subnets have internet access; private subnets are isolated.
- **Elastic Network Interface (ENI)**: Virtual network cards attached to instances.

### 14. Elastic Beanstalk
Elastic Beanstalk automates EC2 management, handling deployment, scaling, and health monitoring of applications.

### 15. Billing and Monitoring
- **Billing**: Charges are based on instance type, region, storage, and data transfer.
- **Monitoring**: AWS CloudWatch helps monitor health, CPU usage, and other instance metrics.

### 16. User Data and Metadata
- **User Data**: Scripts passed to the instance at launch for automating tasks.
- **Metadata**: Information about the instance (e.g., instance ID, IP addresses).

### 17. Placement Groups
Placement Groups are used for controlling the placement of instances:
- **Cluster**: For low-latency, high-bandwidth connectivity.
- **Spread**: For instances distributed across different hardware.
- **Partition**: For isolating failure domains within large-scale applications.

## Use Cases
1. **Web Hosting**: Host websites or web applications.
2. **Big Data Processing**: Run data analytics and machine learning workloads.
3. **Gaming Servers**: Host scalable multiplayer game servers.
4. **Development Environments**: Spin up isolated development and testing instances.
5. **Database Hosting**: Run databases such as MySQL, PostgreSQL on EC2.

## Summary
Amazon EC2 provides a flexible, scalable, and cost-efficient virtual computing environment. EC2 integrates seamlessly with other AWS services, offering a complete cloud solution for hosting applications, processing data, and more.
