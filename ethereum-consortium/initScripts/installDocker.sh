# Docker installation script for Ubuntu 16.04 (Xenial) on Azure
# Usage: execute sudo -i, first.
# wget -q -O - "$@" https://gist.github.com/catataw/63044e79c3cfa20198408130ba52e110/raw/ --no-cache | sh
# After running the script reboot and check whether docker is running.

DOCKER_RESULT=1

while [ $DOCKER_RESULT -ne 0 ]; do
  echo "#################################################"
  echo "  Updating System"
  echo "#################################################"
  apt-get update -y
  apt-get upgrade -y
  apt-get install -y apt-transport-https ca-certificates

  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

  apt-get update -y
  apt-get install -y linux-image-extra-$(uname -r) && sudo modprobe aufs
  rm -f /etc/apt/sources.list.d/docker.list
  su -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' >> /etc/apt/sources.list.d/docker.list"
  apt-get update -y
  echo "#################################################"
  echo "  Purging Docker"
  echo "#################################################"
  apt-get purge lxc-docker
  apt-cache policy docker-engine
  echo "#################################################"
  echo "  Update and Install Docker"
  echo "#################################################"
  apt-get update -y
  apt-get install -y docker-engine
  which docker
  DOCKER_RESULT=$?
  echo "#################################################"
  echo "  Docker install result ${DOCKER_RESULT}"
  echo "#################################################"
done


echo "#################################################"
echo "  Starting Docker "
echo "#################################################"
service docker start

echo ""
echo "#################################################"
echo "  Installing Docker Compose "
echo "#################################################"
curl -L -f -S -s --connect-timeout 5 --retry 15 -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m`
chmod +x /usr/local/bin/docker-compose