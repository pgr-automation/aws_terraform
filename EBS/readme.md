# Amazon Elastic Block Store (EBS)

Amazon Elastic Block Store (EBS) is a high-performance block storage service designed to be used with Amazon EC2 instances. EBS provides persistent storage, ensuring data remains intact even when the associated EC2 instance is stopped or terminated.

## Key Features

### 1. Types of EBS Volumes
- **General Purpose SSD (gp3/gp2)**: Balances price and performance, ideal for most workloads.
- **Provisioned IOPS SSD (io2/io1)**: Offers high performance for mission-critical applications requiring low-latency and high throughput.
- **Throughput Optimized HDD (st1)**: Suitable for frequently accessed, throughput-intensive workloads like big data or log processing.
- **Cold HDD (sc1)**: Designed for infrequent access with lower cost storage needs.

### 2. Snapshots
EBS volumes can be backed up as snapshots, which are stored in Amazon S3. Snapshots can be used to create new volumes or restore existing ones.

### 3. Encryption
EBS volumes can be encrypted to protect data at rest. Encryption is managed by AWS Key Management Service (KMS).

### 4. Elasticity
EBS volumes can be dynamically scaled, allowing you to increase volume size, change volume type, or adjust performance without downtime.

### 5. Performance
EBS is designed for low-latency, high-throughput performance. With io2/io1 volumes, you can provision specific IOPS (Input/Output Operations Per Second) to meet your performance needs.

## Common Use Cases
- **Database Storage**: Ideal for databases like MySQL, PostgreSQL, and Oracle.
- **File Systems**: Suitable for large-scale file systems like Hadoop or Apache Cassandra.
- **Data Warehousing**: Supports data warehousing applications requiring high throughput.

## Common Operations
- **Attaching and Detaching Volumes**: EBS volumes can be attached or detached from EC2 instances as needed. When attached, the volume appears as a device within the instance.
- **Resizing Volumes**: Increase the size of your EBS volume without detaching it from an instance.
- **Creating Snapshots**: Snapshots are incremental backups, meaning only the data that has changed since the last snapshot is saved, reducing storage costs.

For more detailed information, refer to the [AWS EBS Documentation](https://docs.aws.amazon.com/ebs).
