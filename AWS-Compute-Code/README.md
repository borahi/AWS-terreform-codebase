AWS_terraform Code to deploy the AWS Infra,

Which includes,
   1. AWS VPC with 2 public and 2 private subnet ( in Availability zone1 and zone2)
   2. we use IGw at public subnet for traffic to move out
   3. AWS lb target group created which is to be mapped with AWS Auto scalling group
   4. AWS launch configuration crated with image "ami-0bda77bcded5d4a4c"
   5. This launch configuration we used to create the Auto Scalling Group
   6. with desire 2 VM for application and which may be Scale-out to 4 nodes when we apply the cpu load
   7. then we have that Target group is a target for all ALB traffic
   8. Then we have created a RDS machine in the private subnet
   9. RDS machine attched to the front end application to enter user's detail


Credit and thanks to, @Prashant Lakhera, https://www.youtube.com/user/laprashant
                      @Mayank Pandey, https://www.youtube.com/c/knowledgeindia
