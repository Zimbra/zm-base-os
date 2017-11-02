# Requirements for building docker images on Ubuntu

## Installing docker

   * Create login at https://hub.docker.com/ (or setup your docker registry) if you intend to push your images to repository
   * See https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/ for latest instructions
   * Install docker prerequisites
   ```
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
   ```
   * Set up docker's apt repository
   ```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo tee /etc/apt/sources.list.d/docker.list <<EOM
deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
EOM

sudo apt-get update
   ```
   * Install docker
   ```
sudo apt-get install docker-ce
sudo docker run hello-world
   ```
   * Test docker
   ```
sudo apt-get install docker-ce
sudo docker run hello-world
   ```

## Building

   ```
sudo make -j2
   ```

## Pushing to repo

   ```
sudo docker login
sudo make push
   ```
