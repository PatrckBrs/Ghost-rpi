#!groovy

node {
       stage "Preparation du Container"
       dockerNode(image: 'patrckbrs/rpi-jenkins-docker-image-slave:latest', sideContainers: ['']) {
            stage 'Checkout'
            checkout scm
                // TEST 
            stage 'Test'
            sh ls -l
        } 
}
