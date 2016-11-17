#!groovy

node {
        // First stage is actually checking out the source. Since we're using Multibranch
        // currently, we can use "checkout scm".
        stage('Checkout') {
            checkout scm
                // TEST 
        } 
        stage('Docker') {
        dockerNode(image: 'patrckbrs/rpi-jenkins-docker-image-slave:latest', sideContainers: ['bash']) {
        ls -l
        }
        }
}
