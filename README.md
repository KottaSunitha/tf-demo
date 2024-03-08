# tf-demo

This is sample terraform project.

Resources created:
VPC, Igw, Public Subnet, Rtable, RTassociation, Securitygroup, EC2 server

Improvements needed:
1. Need to pass Userdata to install dependencies like docker, AWS-CLI into EC2 VM (Currently installed these manually)
2. Can improve security by placing EC2 on a private subnet, creating Load balancer on a public subnet, creating HTTPS listener to load balancer by attaching ACM certificate (Dont have the registered domain so ACM will not be issued)