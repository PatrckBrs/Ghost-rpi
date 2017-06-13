#!groovy



node('swarm-master') {
   stage 'Update Service'
   sh "docker service update ghost --image ${imageName}:${imageTag}"
}
