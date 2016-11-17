#!groovy

node {
       stage "Preparation du Container"
       git 'https://github.com/PatrckBrs/Ghost-rpi.git'
       dockerNode(image: 'patrckbrs/rpi-jenkins-docker-image-slave:latest', sideContainers: ['']) {
            stage 'Checkout'
            checkout scm
                // TEST 
            stage 'Test'
            sh ls -l
        } 
}
