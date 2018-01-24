This repository contains terraform codes to create AWS Resources (vpc, subnet, ecs, ecr ..) to push and run a docker tomcat image.

AWS Region : eu-west-2 

Create an S3 bucket and use the bucket name in tfstate.tf file (e.g. bucket = "umg-terraform-docker-bucket")

Run Terraform Code to create the insfrastructure

1.terraform init

2.terraform plan -out out.terraform

3.terraform apply out.terraform (you can re-run this command if ecs resource fails) 

4.Check the output for ecr url and application endpoint url. 

Create a Docker Image and push it to Amazon ECR

1. aws configure ( create an IAM user on AWS Console and create Credentials for the user and use those credentials for aws configure, for region use eu-west-2)
2. docker build -t umg_repo
3. docker images  (check and grab the docker image id, e.g da3a20a4e4ba) 
4. Login to AWS ECR 
    eval $(aws ecr get-login --no-include-email | sed 's|https://||')
5. Tag the docker image 
    docker tag local_docker_image_id aws_account_id.dkr.ecr.eu-west-2.amazonaws.com/umg_repo (ecr url taken from terraform output)
6. Push the docker image to AWS ECR
    docker push aws_account_id.dkr.ecr.eu-west-2.amazonaws.com/umg_repo (ecr url taken from terraform output)
    
 
Open your browser and type the applciation endpoint url and check the tomcat homapage.  

