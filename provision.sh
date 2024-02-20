#Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

#Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -y update

#Install docker related components
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Start docker
sudo systemctl start docker     

#Enable docker to run on the boot
sudo systemctl enable docker      

#Created docker group
sudo groupadd docker                

#Add user to docker group
sudo usermod -aG docker $USER       

#Install docker-compose
sudo apt install -y docker-compose


#installing jenkins
sudo docker network create jenkins

#create docker:dind docker image
#sudo docker run --name jenkins-docker --rm --detach \
  #--privileged --network jenkins --network-alias docker \
  #--env DOCKER_TLS_CERTDIR=/certs \
  #--volume jenkins-docker-certs:/certs/client \
  #--volume jenkins-data:/var/jenkins_home \
  #--publish 2376:2376 \
  #docker:dind --storage-driver overlay2

#Build myjenkins-blueocean:2.426.3-1 image
sudo docker build -t myjenkins-blueocean:2.426.3-1 /vagrant

#Run image
#sudo docker run --name jenkins-blueocean --restart=on-failure --detach \
  #--network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  #--env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  #--publish 8080:8080 --publish 50000:50000 \
  #--volume jenkins-data:/var/jenkins_home \
  #--volume jenkins-docker-certs:/certs/client:ro \
  #myjenkins-blueocean:2.426.3-1

cd /vagrant

sudo docker-compose up
