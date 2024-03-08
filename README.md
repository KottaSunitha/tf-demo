# tf-demo

This is sample terraform project.

Resources created:
VPC, Igw, Public Subnet, Rtable, RTassociation, Securitygroup, EC2 server

Improvements needed:
1. Need to pass Userdata to install dependencies like docker, AWS-CLI into EC2 VM (Currently installed these manually)
2. Can improve security by placing EC2 on a private subnet, creasting Load balancer on a public subnet, creating HTTPS listener to load balancer by attaching ACM certificate (Dont have the registered domain so ACM will not be issued)
3. Can work on dedicated security groups for ALB and EC2 so that we can expose HTTPS (443) traffic from ALB to public access and restrict EC2 from exposing the unsecured ports