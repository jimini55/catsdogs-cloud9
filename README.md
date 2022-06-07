# catsdogs-cloud9

requirements:
1. generate the keys
2. clone to the repository via: git clone "ssh or http link"
3. build the infrastructure
4. update the secrets in your git to access the ecr.
5. create and build a workflow using git to update the images automatically.

#build a terraform code
<!--tf init-->
<!--tf fmt-->
<!--tf validate-->
<!--tf plan-->
<!--tf apply --auto-approve-->


# to login into the ecr
   aws configure
   vi ~/.aws/credentials
 Note: update the default user with ecr-user
  aws ecr get-login --region us-east-1
  sudo docker login -u AWS -p "ecr_login_credentials
   
#to install the dokcer
   docker
   sudo apt-get install docker
   sudo yum install docker
   sudo systemctl start docker
   sudo systemctl status docker
   sudo docker
 

# to list all images : docker ps

#to pull the images in your ecr registery:
   sudo docker pull "image uri"
   example: sudo docker pull 858011229774.dkr.ecr.us-east-1.amazonaws.com/docker:catssv1
 
 #to check the container images
   sudo docker images
   sudo docker run -d -p "define ports" --name "give name" "image uri"
   example: sudo docker run -d -p 8080:80 --name kajal  858011229774.dkr.ecr.us-east-1.amazonaws.com/docker:dogsv1

 #to execute a docker 
   sudo docker exec -it "container-id" bash
   sudo docker exec -it 5049269a7a0e bash
  
#to create a docker network
   sudo docker create "provide a name for network"
   sudo docker create mynetwork
   sudo docker network create mynetwork
   
#to connect with the images
   sudo docker network connect "container-name"
   sudo docker network connect kajal

# to ping
execute a container
perform following commands to ping:
1. apt-get update
2. apt-get install iputils-ping
3. ping "container_name"
